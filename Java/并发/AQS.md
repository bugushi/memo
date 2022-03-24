# 介绍
AbstractQueuedSynchronizer是一个抽象类，用于控制线程执行顺序
- volatile int state 代表共享资源状态
- FIFO队列，排队的线程进入队列
- 底层基于 UNSAFE.park()，UNSAFE.unpark() 实现
- 应用于 ReentrantLock, CountDownLatch， Semaphore等
![](../../images/java/aqs.image)

# 常用方法
- getState
- setState
- tryAcquire
- tryRelease

# 参见
- [【深入AQS原理】我画了35张图就是为了让你深入 AQS - cnblogs ](https://www.cnblogs.com/wang-meng/p/12816829.html)