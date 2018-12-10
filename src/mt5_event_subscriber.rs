pub struct Mt5EventSubscriber {
    pub socket: zmq::Socket,
}

#[allow(dead_code)]
pub struct Mt5EventZmqFrames {
    pub topic: Vec<u8>,
    pub name: Vec<u8>,
    pub payload: Vec<u8>,
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
    pub fn new(ctx: zmq::Context, topic: &[u8], uri: &str) -> Self {
        let socket = ctx.socket(zmq::SUB).unwrap();
        socket.set_subscribe(topic).unwrap();
        socket.connect(uri).unwrap();
        Self { socket: socket }
    }
}
