# 区别
- defer异步下载，最后执行（相当于放在body后）
    - 多个defer之间会按顺序执行
- async异步下载，阻塞执行
    - 一般用于和页面无依赖的场景，如：Google Analytics

![](../../images/frontend/async_defer.png)

# 参见
- [defer和async的区别 - segmentfault](https://segmentfault.com/q/1010000000640869)