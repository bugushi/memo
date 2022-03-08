# 常用方法
- Optional.empty()
- Optional.of(value)
- Optional.ofNullable(value)
- instance.isPresent() // 非null值时，为true
- get() // 会有空指针异常
- orElese() // 取值，为null则用默认值

# map 与 flatmap
map
```java
assertEquals(Optional.of(Optional.of("STRING")), Optional.of("string").map(s -> Optional.of("STRING")));
```

flatmap
```java
assertEquals(Optional.of("STRING"), Optional.of("string").flatMap(s -> Optional.of("STRING")));
```
