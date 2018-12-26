use mt5_event::MT5EventFrames;
use protobuf::parse_from_bytes;
use tick::Tick;

#[derive(Debug)]
pub struct NamedTick {
    pub symbol: String,
    pub tick: Tick,
}

impl NamedTick {
    pub fn from_frames(frames: MT5EventFrames) -> NamedTick {
        NamedTick {
            symbol: String::from_utf8(frames.name).unwrap(),
            tick: parse_from_bytes(&frames.payload).unwrap(),
        }
    }
}
