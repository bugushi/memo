# Hystrix工作原理
- 基于线程池或者信号量隔离，一旦下游服务超时则降级
- 滑动时间窗口内，失败比例超过阈值则熔断，一旦熔断，所有请求都降级
- 熔断超过一定时间，尝试半开放，测试是否可放开熔断


hystrix定义一组command，每个路由选择使用command，每个command使用一个线程池，总体存放到 ConcurrentHashMap 中
```java
final static ConcurrentHashMap<String, HystrixThreadPool> threadPools = new ConcurrentHashMap<String, HystrixThreadPool>();
threadPools.put(“hystrix-order”, new HystrixThreadPoolDefault(threadPoolKey, propertiesBuilder));
```

# 使用
hystrix已不再维护
### 依赖
```xml
    <dependencies>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-gateway</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-starter-netflix-hystrix</artifactId>
        </dependency>
    </dependencies>    
```

### 配置
使用`HystrixGatewayFilterFactory`过滤请求, `.yaml`中的配置信息会在此filter中生效

对单个路由生效
```yaml
// 执行超时时间为1秒，会对下面路由order_route绑定的HystrixGatewayFilterFactory生效
hystrix.command.fallbackcmd.execution.isolation.thread.timeoutInMilliseconds: 1000

spring:
  cloud:
    gateway:
      routes:
      - id: order_route
        uri: http://localhost:9091
        predicates:
        - Path=/order/**
        filters:
        - name: Hystrix
          args:
            name: HystrixCommand
            fallbackUri: forward:/fallback
```
对全局生效（不推荐）
```yaml
spring:
  cloud:
    gateway:
      routes:
        - id: order_route
          uri: http://localhost:9091
          predicates:
            - Path=/order/**
      default-filters:
        - name: Hystrix
          args:
            name: HystrixCommand
            fallbackUri: forward:/fallback
```

### fallback处理
定义controller
```java
@RestController
public class FallbackController {

    @RequestMapping(value = "/fallback")
    @ResponseStatus
    public Mono<Map<String, Object>> fallback(ServerWebExchange exchange, Throwable throwable) {
        Map<String, Object> result = new HashMap<>(8);
        ServerHttpRequest request = exchange.getRequest();
        result.put("path", request.getPath().pathWithinApplication().value());
        result.put("method", request.getMethodValue());
        if (null != throwable.getCause()) {
            result.put("message", throwable.getCause().getMessage());
        } else {
            result.put("message", throwable.getMessage());
        }
        return Mono.just(result);
    }
}
```

# 定制Hystrix过滤器
也可以定制过滤器，比如：
- 给每个url使用不同的过滤器
- 每个URL可以指定特有的线程池配置，如果不指定则使用默认的。
- 每个url单独设置hystrix超时时间

# 参见
- [hystrix线程隔离技术解析](https://www.jianshu.com/p/df1525d58c20)
- [hystrix自定义过滤器 - 腾讯云](https://cloud.tencent.com/developer/article/1650037)