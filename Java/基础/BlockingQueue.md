# 类型
- 无界
    - LinkedBlockingQueue<>();
    - PriorityBlockingQueue<>();
- 有界
    - ArrayBlockingQueue<>(10);
    > 其它无界队列可以传参变成有界

# 添加
- add() true 或者 IllegalStateException
- put() 加入 或者等待
- offer() true 或者 false
- offer(E e, Long timeout, TimeUnit unit) 重试加入，知道超时false

# 取出
- take() 取出或等待
- poll(long timeout, TimeUnit unit) 取出或等待超时

# 使用
控制消费线程节奏
```java
BlockingQueue<Integer> queue = new LinkedBlockingQueue<>();
// 生产线程
queue.put(ThreadLocalRandom.current().nextInt(100));
Thread.sleep(1000);
queue.put(ThreadLocalRandom.current().nextInt(100));
Thread.sleep(1000);
queue.put(poisonPill);

// 消费线程
Integer number = queue.take();
if(number == poisonPill) return;
...
```

# 参考
- [java blocking queue - baeldung](https://www.baeldung.com/java-blocking-queue)
