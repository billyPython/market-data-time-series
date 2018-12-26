pub struct MT5EventSubscriber {
    pub socket: zmq::Socket,
}

#[allow(dead_code)]
pub struct MT5EventFrames {
    pub topic: Vec<u8>,
    pub name: Vec<u8>,
    pub payload: Vec<u8>,
}

impl Iterator for MT5EventSubscriber {
    type Item = MT5EventFrames;

    fn next(&mut self) -> Option<MT5EventFrames> {
        let mut data = self.socket.recv_multipart(0).unwrap();
        let payload = data.pop().unwrap();
        let name = data.pop().unwrap();
        let topic = data.pop().unwrap();
        Some(MT5EventFrames {
            topic: topic,
            name: name,
            payload: payload,
        })
    }
}

impl MT5EventSubscriber {
    pub fn new(ctx: zmq::Context, topic: &[u8], uri: &str) -> Self {
        let socket = ctx.socket(zmq::SUB).unwrap();
        socket.set_subscribe(topic).unwrap();
        socket.connect(uri).unwrap();
        Self { socket: socket }
    }
}
