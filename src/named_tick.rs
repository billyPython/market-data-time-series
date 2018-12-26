use super::tick::Tick;
use protobuf::parse_from_bytes;

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
