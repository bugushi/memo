# Future
Future是一个接口，FutureTask是Future接口的唯一实现类
```java
FutureTask ft = threadpool.submit(Runnable task);
```

常用方法
- isDone()
- cancel()
- get() 会阻塞

### ForkJoinTask
- ForkJoinTask 是一个实现 Future 接口的抽象类，作为 ForkJoinPool 的入参
- RecursiveTask 和 RecursiveAction 是 ForkJoinTask 的两个抽象实现类

```java
// 级数平方和，递归的异步版本
public class FactorialSquareCalculator extends RecursiveTask<Integer> {
    private Integer n;
    public FactorialSquareCalculator(Integer n) {
        this.n = n;
    }

    @Override
    protected Integer compute() {
        if (n <= 1) return n;
        FactorialSquareCalculator calculator 
          = new FactorialSquareCalculator(n - 1);
        calculator.fork();
        return n * n + calculator.join();
    }
}
```
```java
ForkJoinPool forkJoinPool = new ForkJoinPool();
FactorialSquareCalculator calculator = new FactorialSquareCalculator(10);
forkJoinPool.execute(calculator);
```

# 参见
- [Future - baeldung](https://www.baeldung.com/java-future)