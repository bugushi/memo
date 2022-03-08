# 介绍
实现了 Future 接口和 CompletionStage 接口

# 发起方法
- completeFuture(T)
- runAsync(Runnable r)
- supplyAsync(Supplier s)
    > Supplier接口是个通用函数式接口，可用lamda

# 接收方法
supplyAsync 返回一个 CompletableFutre实例

- thenAccept(lamda) 返回void
- thenApply(lamda) 有返回值，继续返回 CompletableFuture 实例，可链式调用
- thenRun(Runnable) 无返回值
> 以上方法的lamda，都会在调用 future.get() 后执行
```java
CompletableFuture<String> completableFuture
  = CompletableFuture.supplyAsync(() -> "Hello");

CompletableFuture<String> future = completableFuture
  .thenApply(s -> s + " World");

assertEquals("Hello World", future.get());
```

# 链式调用
thenCompose(lamda) 使用上一个future的返回值
```java
CompletableFuture<String> completableFuture 
  = CompletableFuture.supplyAsync(() -> "Hello")
    .thenCompose(s -> CompletableFuture.supplyAsync(() -> s + " World"));

assertEquals("Hello World", completableFuture.get());
```

thenCombine(future, lamda), 组合另外一个future，并通过函数计算
```java
CompletableFuture future = CompletableFuture.supplyAsync(() -> "Hello")
  .thenAcceptBoth(CompletableFuture.supplyAsync(() -> " World"),
    (s1, s2) -> System.out.println(s1 + s2));
```

# 多Future方法
allOf(future1, future2, future3)
```java
CompletableFuture<String> future1  
  = CompletableFuture.supplyAsync(() -> "Hello");
CompletableFuture<String> future2  
  = CompletableFuture.supplyAsync(() -> "Beautiful");
CompletableFuture<String> future3  
  = CompletableFuture.supplyAsync(() -> "World");

CompletableFuture<Void> combinedFuture 
  = CompletableFuture.allOf(future1, future2, future3);
```
join() 合并future
```java
String combined = Stream.of(future1, future2, future3)
  .map(CompletableFuture::join)
  .collect(Collectors.joining(" "));

assertEquals("Hello Beautiful World", combined);
```

# 错误处理
handle()
```java
String name = null;

// ...

CompletableFuture<String> completableFuture  
  =  CompletableFuture.supplyAsync(() -> {
      if (name == null) {
          throw new RuntimeException("Computation error!");
      }
      return "Hello, " + name;
  }).handle((s, t) -> s != null ? s : "Hello, Stranger!");

assertEquals("Hello, Stranger!", completableFuture.get());
```

completeExceptionally()
```java
CompletableFuture<String> completableFuture = new CompletableFuture<>();

// ...

completableFuture.completeExceptionally(
  new RuntimeException("Calculation failed!"));

// ...

completableFuture.get(); // ExecutionException
```

# 异步
thenApplyAsync() 底层使用ForkJoinPool（所有带async后缀的都是）
> thenApply() 使用当前线程

```java
CompletableFuture<String> completableFuture  
  = CompletableFuture.supplyAsync(() -> "Hello");

CompletableFuture<String> future = completableFuture
  .thenApplyAsync(s -> s + " World");

assertEquals("Hello World", future.get());
```

# 参考
- [CompletableFuture - baeldung](https://www.baeldung.com/java-completablefuture)