# Java基础


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

### 线程安全
