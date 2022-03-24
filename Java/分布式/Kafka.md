# 结构

# 生产者

# 消费者
- 每个group中，只有一个消费者可消费某个topic
- 多个group消费同一个topic，则每个group都会收到消息

# 推还是拉
一般默认都是拉，consumer使用长轮询的方式请求broker

# 参见
- [Kafka Consumer Group - stackoverflow](https://stackoverflow.com/questions/23136500/how-kafka-broadcast-to-many-consumer-groups)
- [消息队列之推还是拉 - segmentfault](https://segmentfault.com/a/1190000023854950)