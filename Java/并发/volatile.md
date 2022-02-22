## volatile存在的原因
- 缓存一致性问题
    > 多核处理器有各自的缓存，A核心更新了线程共享变量x，B核心里的x缓存没有立即更新
- 重排序
    > cpu可能对写操作瞎几把优化导致和代码顺序不一致

### volatile的作用
- 立即更新缓存
- 强制不重排序

### hapens before
volatile变量之前的操作，会先于volatile同步到内存中。

利用这种特性，可以只把一个变量标识为volatile（！！！但是别这么做，没事找事）
```java
public class TaskRunner {

    private static int number; // not volatile, but act as volatile
    private volatile static boolean ready;

    // same as before
}
```