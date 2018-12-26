use mt5_event_subscriber::Mt5EventZmqFrames;
use protobuf::parse_from_bytes;
use tick::Tick;

#[derive(Debug)]
pub struct NamedTick {
    pub tick: Tick,
    pub symbol: String,
}

impl NamedTick {
    pub fn from_frames(frames: Mt5EventZmqFrames) -> NamedTick {
        NamedTick {
            symbol: String::from_utf8(frames.name).unwrap(),
            tick: parse_from_bytes(&frames.payload).unwrap(),
        }
    }
}
