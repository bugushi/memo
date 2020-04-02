# Java基础

### 什么是RawTypes
```java
List list = new ArrayList(); // raw type
List<Integer> listIntgrs = new ArrayList<>(); // parameterized type
```

### `Array` 和 `ArrayList`
Array定长、定类型；ArrayList变长、泛型

### `HashMap` 和 `HashTable`
键值对，HashMap允许null键和null值，异步线程不安全

HashMap将键entry(键值对)取hash，存在默认16个桶中，分配在同一个桶中的entry使用链表结构，同一个桶中超过8个entry，则改为红黑树，以提高查询性能

> Default initial capacity of the HashMap takes is 16 and load factor is 0.75f (i.e 75% of current map size). The load factor represents at what level the HashMap capacity should be doubled.

> For example product of capacity and load factor as 16 * 0.75 = 12. This represents that after storing the 12th key – value pair into the HashMap , its capacity becomes 32.

### 自旋锁
自旋锁 = 轮询
互斥锁 = 异步

### 反射
通过字符串获得类或者接口

### 有了接口为什么还需要抽象类
- 类可以实现无限个接口，但只能从一个抽象类继承
- 接口方法只有public声明，但抽象类可以有非抽象方法
- 接口只有static final成员变量，而抽象类可以有各种成员
- 抽象类是对对象的抽象，而接口是一种行为规范


### 线程安全


### 为什么匿名函数调用的类成员需要指定为final类型
因为final类型的类成员，会拷贝一份到匿名函数中。这样当类成员随着类销毁，匿名函数还可以保持正常运行

### 类加载器
- 引导类加载器（bootstrap class loader）：它用来加载 Java 的核心库，是用原生代码来实现的，并不继承自 java.lang.ClassLoader。
- 扩展类加载器（extensions class loader）：它用来加载 Java 的扩展库。Java 虚拟机的实现会提供一个扩展库目录。该类加载器在此目录里面查找并加载 Java 类。
- 系统类加载器（system class loader）：它根据 Java 应用的类路径（CLASSPATH）来加载 Java 类。一般来说，Java 应用的类都是由它来完成加载的。可以通过 ClassLoader.getSystemClassLoader()来获取它。

![类加载器](https://www.ibm.com/developerworks/cn/java/j-lo-classloader/image001.jpg)
