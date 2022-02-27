# 数据类型
![](../../images/java/map.jpeg)

# LinkedHashMap
有序的hashmap，默认遍历顺序为插入顺序，额外保存了双向链表用以存储数据

可以借以实现LRU
```java
class LRUCache extends LinkedHashMap<Integer, Integer>{
    private int maxSize;
    public LRUCache(int capacity) {
        // true表示是否使用访问顺序，否则使用插入顺序
        super(capacity, 0.75f, true);
        this.maxSize = capacity;
    }

    //return -1 if miss
    public int get(int key) {
        Integer v = super.get(key);
        return v == null ? -1 : v;
    }

    public void put(int key, int value) {
        super.put(key, value);
    }

    @Override
    protected boolean removeEldestEntry(Map.Entry<Integer, Integer> eldest) {
        return this.size() > maxSize; //must override it if used in a fixed cache
    }
}
```

# TreeMap
TreeMap 本质上就是一棵“红黑树”，而 TreeMap 的每个 Entry 就是该红黑树的一个节点。

红黑树是一个平衡的二叉查找树，用颜色约束告诉，防止二叉查找树变成长短腿（不平衡），CRUD复杂度都有O(logN)。

### 使用场景
计算签名前的字典排序
# 参见
- [TreeMap面试题](https://z.itpub.net/article/detail/019FFB8741ADB2AAFBE5682C36D7C15B)
- [TreeMap结构](https://developer.aliyun.com/article/819637)