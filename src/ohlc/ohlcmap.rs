use super::super::protobuf_tick::named_tick::NamedTick;
use super::ohlc::Ohlc;
use std::collections::hash_map::Entry;
use std::collections::HashMap;

pub struct OhlcMap {
    pub map: HashMap<String, Ohlc>,
    pub min: i64,
}

impl OhlcMap {
    pub fn new() -> Self {
        OhlcMap {
            map: HashMap::new(),
            min: 0,
        }
    }
    pub fn update(&mut self, tick: &NamedTick) {
        let tick_min = tick.tick.datetime / 60;
        if self.min != tick_min {
            for ohlc in self.map.values_mut() {
                ohlc.prep_next();
            }
            self.min = tick_min;
        }
        self.update_ohlc(tick);
    }
    pub fn is_next_min(&self, tick: &NamedTick) -> bool {
        (tick.tick.datetime / 60) != self.min && self.min != 0
    }
    fn update_ohlc(&mut self, tick: &NamedTick) {
        match self.map.entry(tick.symbol.clone()) {
            Entry::Occupied(o) => o.into_mut().add_tick(tick),
            Entry::Vacant(v) => {
                v.insert(Ohlc::new(tick));
            }
        };
    }
}
