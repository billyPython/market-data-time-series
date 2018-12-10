extern crate protobuf;
extern crate zmq;

use protobuf::parse_from_bytes;
mod tick;
use std::str;
use tick::Tick;

struct Mt5EventSubscriber {
    socket: zmq::Socket,
}

#[allow(dead_code)]
struct Mt5EventZmqFrames {
    topic: Vec<u8>,
    name: Vec<u8>,
    payload: Vec<u8>,
}

#[derive(Debug)]
struct NamedTick {
    tick: Tick,
    symbol: String,
}

impl Iterator for Mt5EventSubscriber {
    type Item = Mt5EventZmqFrames;

    fn next(&mut self) -> Option<Mt5EventZmqFrames> {
        let mut data = self.socket.recv_multipart(0).unwrap();
        let payload = data.pop().unwrap();
        let name = data.pop().unwrap();
        let topic = data.pop().unwrap();
        Some(Mt5EventZmqFrames {
            topic: topic,
            name: name,
            payload: payload,
        })
    }
}
impl Mt5EventSubscriber {
    fn new(ctx: zmq::Context, topic: &[u8], uri: &str) -> Self {
        let socket = ctx.socket(zmq::SUB).unwrap();
        socket.set_subscribe(topic).unwrap();
        socket.connect(uri).unwrap();
        Self { socket: socket }
    }
}

fn zmq2tick(tick: Mt5EventZmqFrames) -> NamedTick {
    NamedTick {
        symbol: String::from_utf8(tick.name).unwrap(),
        tick: parse_from_bytes(&tick.payload).unwrap(),
    }
}

fn main() {
    let ctx = zmq::Context::new();
    let subscriber = Mt5EventSubscriber::new(ctx, b"MDT", "tcp://mt5proxy.tradecore.io:8149");

    let ticker = subscriber
        .into_iter()
        //.filter(|x| str::from_utf8(&x.name).unwrap() == "EURUSD")
        .map(zmq2tick);

    for x in ticker {
        println!("{:#?}", x);
        println!("");
    }
}

//#[macro_use]
//extern crate influx_db_client;
//extern crate zmq;
//
//use influx_db_client::{Client, Point, Points, Value, Precision};
//
//fn main() {
//    // default with "http://127.0.0.1:8086", db with "test"
//    let client = Client::default().set_authentication("admin", "admin");
//
//    let mut point = point!("test1");
//    point
//        .add_field("foo", Value::String("bar".to_string()))
//        .add_field("integer", Value::Integer(11))
//        .add_field("float", Value::Float(22.3))
//        .add_field("'boolean'", Value::Boolean(false));
//
//    let point1 = Point::new("test1")
//        .add_tag("tags", Value::String(String::from("\\\"fda")))
//        .add_tag("number", Value::Integer(12))
//        .add_tag("float", Value::Float(12.6))
//        .add_field("fd", Value::String("'3'".to_string()))
//        .add_field("quto", Value::String("\\\"fda".to_string()))
//        .add_field("quto1", Value::String("\"fda".to_string()))
//        .to_owned();
//
//    let points = points!(point1, point);
//
//    // if Precision is None, the default is second
//    // Multiple write
//    let _ = client.write_points(points, Some(Precision::Seconds), None).unwrap();
//
//    // query, it's type is Option<Vec<Node>>
//    let res = client.query("select * from test1", None).unwrap();
//    println!("{:?}", res.unwrap()[0].series);
//
//    let ctx = zmq::Context::new();
//    let socket = ctx.socket(zmq::SUB).unwrap();
//    socket.set_subscribe(b"MDT");
//    socket.connect("tcp://mt5proxy.tradecore.io:8149").unwrap();
//    loop {
//        let msg = socket.recv_multipart(0).unwrap();
//        println!("{:?}", msg);
//    }
//}
