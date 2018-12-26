use super::super::protobuf_tick::named_tick::NamedTick;

#[derive(Debug)]
pub struct Ohlc {
    pub open: f64,
    pub high: f64,
    pub low: f64,
    pub close: f64,
    pub volume: u64,
}

impl Ohlc {
    pub fn new(tick: &NamedTick) -> Self {
        let bid: f64 = tick.tick.bid.parse().unwrap();
        let volume = tick.tick.volume;
        Self {
            open: bid,
            high: bid,
            low: bid,
            close: bid,
            volume: volume,
        }
    }
    pub fn prep_next(&mut self) {
        self.volume = 0;
        self.open = self.close;
        self.low = self.close;
        self.high = self.close;
    }
    pub fn add_tick(&mut self, tick: &NamedTick) {
        let bid: f64 = tick.tick.bid.parse().unwrap();
        if self.high < bid {
            self.high = bid;
        }
        if self.low > bid {
            self.low = bid;
        }
        self.close = bid;
        self.volume = self.volume + tick.tick.volume;
    }
}
