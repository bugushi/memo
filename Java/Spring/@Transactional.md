
# 介绍
基于AOP实现事务
- 应用于类，该类的所有public方法，都具有事务性
- 应用于方法，方法的事务配置会覆盖类的事务配置
- 应用于接口，不推荐，因为和启用cglib会起冲突，导致事务失效

常用属性
- propgation
    - propgation.REQUIRED 如果当前存在事务则合并事务，否则创建新事务
    - .SUPPORTS 合并事务，或非事务运行
    - .MANDATORY 合并事务，或抛出异常
    - .REQUIRES_NEW 创建新事务，或抛出异常
    - .NOT_SUPPORTED 暂停当前事务，或以非事务运行
    - .NEVER 抛出异常，或以非事务方式运行
- isolation 隔离级别
- timeout 超时
- readonly 标识是否为只读事务
- rollbackFor 指定触发回滚的异常类型
- noRollbackFor 抛出指定异常则不回滚事务

# 失效场景
### 应用在非 public 方法
- 事务拦截器 TransactionIntercepter 基于AOP实现
- 不管是 cglib 还是 jdk proxy，最终都会调用 AbstractFallbackTransactionAttributeSource 的 computeTransactionAttribute方法
- 该方法会不处理非 public 方法
> 注意，用@Transactional修饰非 public方法，虽然事务不生效，但是不会报错，所以要小心

### propgation设置错误

### 抛出了自定义类型的异常
- Spring默认抛出 unchecked异常（继承自RuntimeException）或者 Error 才回滚事务
- 如果抛出了其它类型异常，需要定义 rollbackFor属性

### 同一个类中调用
- aop 代理是基于类生成新的代理类，来实现事务性
- 原始类内部，还是使用原始类方法，不会被代理

### 异常被自己的catch吃了

# 参见
- [@Transactional 的失效场景](https://juejin.cn/post/6844904096747503629)