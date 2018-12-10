extern crate influx_db_client;
extern crate zmq_event_sub;

use influx_db_client::{Client, Point, Points, Precision, Value};

use zmq_event_sub::mt5_event_subscriber::{Mt5EventSubscriber, Mt5EventZmqFrames};
use zmq_event_sub::ohlc::ohlcmap::OhlcMap;
use zmq_event_sub::protobuf_tick::named_tick::NamedTick;

fn zmq2tick(tick: Mt5EventZmqFrames) -> NamedTick {
    NamedTick {
        symbol: String::from_utf8(tick.name).unwrap(),
        tick: NamedTick::parse_tick_from_bytes(&tick.payload),
    }
}

fn main() {
    let client =
        Client::new("http://192.168.56.1:8086", "mydb").set_authentication("mt5feed", "mt5feed");

    let ctx = zmq_event_sub::zmq::Context::new();
    let subscriber = Mt5EventSubscriber::new(ctx, b"MDT", "tcp://mt5proxy.tradecore.io:8149");
    let mut ohlc_map = OhlcMap::new();

    for tick in subscriber.into_iter().map(zmq2tick) {
        if ohlc_map.is_next_min(&tick) {
            let mut measurements = Points { point: Vec::new() };
            for (symbol, ohlc) in &ohlc_map.map {
                let timestamp = ohlc_map.min * 60;
                let measurement = Point::new(symbol)
                    .add_field("open", Value::Float(ohlc.open))
                    .add_field("high", Value::Float(ohlc.high))
                    .add_field("low", Value::Float(ohlc.low))
                    .add_field("close", Value::Float(ohlc.close))
                    .add_field("volume", Value::Integer(ohlc.volume as i64))
                    .add_timestamp(timestamp)
                    .to_owned();
                measurements.push(measurement);
                println!("{} : {:#?}", symbol, ohlc);
            }
            let _ = client
                .write_points(measurements, Some(Precision::Seconds), None)
                .unwrap();
            println!("***************{}**********************", ohlc_map.min);
        }
        ohlc_map.update(&tick);
    }
}
