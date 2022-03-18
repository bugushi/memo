# 命令
- `top -Hp pid` 查看线程信息
- `jinfo -flags pid` 查看JVM参数
- `jstat -gcutil pid 1000 5` 每隔1s打印gc信息，共打印5次
- `jmap -histo pid | head -n20` 查看存活对象，排序前20个
- `jmap -dump:format=b,file=heap pid` dump文件
- `jstack pid` 查看堆栈，查看线程blocking代码位置
    > ![](../../images/java/thread_status.awebp)

# 可视化工具
- gceasy.io

# 案例
- 给运营提供绕过分页查询的url，运营一次查询太多数据

# 参见
- [jstack命令解析 - 掘金](https://juejin.cn/post/6844904152850497543)