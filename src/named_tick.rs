use mt5_event_subscriber::Mt5EventZmqFrames;
use protobuf::parse_from_bytes;
use tick::Tick;

#[derive(Debug)]
pub struct NamedTick {
    pub tick: Tick,
    pub symbol: String,
}

impl NamedTick {
    pub fn parse_tick_from_bytes(bytes: &[u8]) -> Tick {
        parse_from_bytes(bytes).unwrap()
    }
}
