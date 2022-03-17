# 介绍
- CountDownLatch 主线程等待子线程完成，汇总后继续
- CyclicBarrier 所有子线程走准备完毕，子线程才开始执行
- Semaphore 限制同时执行的线程数，用于限流

# CountDownLatch
```java
public class CountDownTest {
    static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    public static void main(String[] args) throws InterruptedException {
        CountDownLatch latch = new CountDownLatch(2);
        Worker w1 = new Worker("张三", 2000, latch);
        Worker w2 = new Worker("李四", 3000, latch);
        w1.start();
        w2.start();

        long startTime = System.currentTimeMillis();
        latch.await();
        System.out.println("bug全部解决，领导可以给客户交差了，任务总耗时： "+ (System.currentTimeMillis() - startTime));

    }

    static class Worker extends Thread{
        String name;
        int workTime;
        CountDownLatch latch;

        public Worker(String name, int workTime, CountDownLatch latch) {
            this.name = name;
            this.workTime = workTime;
            this.latch = latch;
        }

        @Override
        public void run() {
            System.out.println(name+"开始修复bug，当前时间："+sdf.format(new Date()));
            doWork();
            System.out.println(name+"结束修复bug，当前时间： "+sdf.format(new Date()));
            latch.countDown();
        }

        private void doWork() {
            try {
                //模拟工作耗时
                Thread.sleep(workTime);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
```

# CyclicBarrier
底层靠ReentrantLock实现，子线程互相等待，靠Condition.signalAll()唤起等待线程
```java
class Athlete implements Runnable {

    private CyclicBarrier cyclicBarrier;
    private String name;

    public Athlete(CyclicBarrier cyclicBarrier, String name) {
        this.cyclicBarrier = cyclicBarrier;
        this.name = name;
    }

    @Override
    public void run() {
        System.out.println(name + "就位");
        try {
            cyclicBarrier.await();
            Random random =new Random();
            double time = random.nextDouble() + 9;
            System.out.println(name + ": "+ time);
        } catch (Exception e) {
        }
    }
}

class Race {
    private CyclicBarrier cyclicBarrier = new CyclicBarrier(8);
    public void start() {
        List<Athlete> athleteList = new ArrayList<>();
        athleteList.add(new Athlete(cyclicBarrier,"博尔特"));
        athleteList.add(new Athlete(cyclicBarrier,"鲍威尔"));
        athleteList.add(new Athlete(cyclicBarrier,"盖伊"));
        athleteList.add(new Athlete(cyclicBarrier,"布雷克"));
        athleteList.add(new Athlete(cyclicBarrier,"加特林"));
        athleteList.add(new Athlete(cyclicBarrier,"苏炳添"));
        athleteList.add(new Athlete(cyclicBarrier,"路人甲"));
        athleteList.add(new Athlete(cyclicBarrier,"路人乙"));
        Executor executor = Executors.newFixedThreadPool(8);
        for (Athlete athlete : athleteList) {
            executor.execute(athlete);
        }
    }
}
```

# Semaphore
```java
public class SemaphoreTest {
    private static int count = 20;

    public static void main(String[] args) {

        ExecutorService executorService = Executors.newFixedThreadPool(count);

        //指定最多只能有五个线程同时执行
        Semaphore semaphore = new Semaphore(5);

        Random random = new Random();
        for (int i = 0; i < count; i++) {
            final int no = i;
            executorService.execute(new Runnable() {
                @Override
                public void run() {
                    try {
                        //获得许可
                        semaphore.acquire();
                        System.out.println(no +":号车可通行");
                        //模拟车辆通行耗时
                        Thread.sleep(random.nextInt(2000));
                        //释放许可
                        semaphore.release();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            });
        }

        executorService.shutdown();

    }
}
```

# 参见
- [JUC常用同步工具类——CountDownLatch，CyclicBarrier，Semaphore](https://juejin.cn/post/6844904083216662536)
- [深入浅出java CyclicBarrier](https://www.jianshu.com/p/424374d71b67)