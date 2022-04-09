# 介绍
- 渲染前执行
- 同步执行，阻塞渲染

# 场景
- 如果useEffect中改变依赖的state，会导致二次渲染，页面闪烁，如果要避免，可使用useLayoutEffect
- 绝大多数场景，不需要使用useLayoutEffect，因为会阻塞渲染

# 参见
- [useEffect 和 useLayoutEffect 的区别 - 掘金](https://juejin.cn/post/6844904008402862094)