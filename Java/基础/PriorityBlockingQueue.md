# 介绍
- 实现了 BlockingQueue 接口
- 底层平衡二叉树
- 加入的元素必须实现Comparable接口
- 取出时自动取出最小元素

```java
PriorityBlockingQueue<Integer> queue = new PriorityBlockingQueue<>();
ArrayList<Integer> polledElements = new ArrayList<>();
queue.add(1);
queue.add(5);
queue.add(2);
queue.add(3);
queue.add(4);

queue.drainTo(polledElements);
assertThat(polledElements).containsExactly(1, 2, 3, 4, 5);
```

# 使用
```java
PriorityBlockingQueue<Integer> queue = new PriorityBlockingQueue<>();
Thread thread = new Thread(() -> {
    System.out.println("Polling...");
    while (true) {
        try {
            Integer poll = queue.take();
            System.out.println("Polled: " + poll);
        } 
        catch (InterruptedException e) { 
            e.printStackTrace();
        }
    }
});

thread.start();

Thread.sleep(TimeUnit.SECONDS.toMillis(5));
System.out.println("Adding to queue");

queue.addAll(newArrayList(1, 5, 6, 1, 2, 6, 7));
```