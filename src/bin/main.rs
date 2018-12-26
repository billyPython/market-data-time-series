extern crate influx_db_client;
extern crate market_data_time_series;

use influx_db_client::{Client, Point, Precision, Value};

use market_data_time_series::mt5_event_subscriber::Mt5EventSubscriber;
use market_data_time_series::ohlc::Ohlc;
use market_data_time_series::named_tick::NamedTick;

fn main() {
    let ctx = market_data_time_series::zmq::Context::new();
    let subscriber = Mt5EventSubscriber::new(ctx, b"MDT", "tcp://mt5proxy.tradecore.io:8149");
    let client = Client::new("http://influxdb:8086", "mdts").set_authentication("mt5", "mt5");

    for named_tick in subscriber.into_iter().map(NamedTick::from_frames) {
        let ohlc = Ohlc::new(&named_tick);
        let point = Point::new("ticks")
            .add_tag("symbol", Value::String(named_tick.symbol))
            .add_field("open", Value::Float(ohlc.open))
            .add_field("high", Value::Float(ohlc.high))
            .add_field("low", Value::Float(ohlc.low))
            .add_field("close", Value::Float(ohlc.close))
            .add_field("volume", Value::Integer(ohlc.volume as i64))
            .add_timestamp(named_tick.tick.datetime)
            .to_owned();
        // TODO: Retention policy
        // TODO: Clone?
        match client.write_point(point.clone(), Some(Precision::Seconds), None) {
            Ok(_) => println!("Wrote: {:?}", point),
            Err(error) => println!("Error: {}", error),
        }
    }
}
