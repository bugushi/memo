# 为什么
- OOP中，日志，安全检查，事务，异常处理等切面会造成大量重复代码
- OOP的解决办法是使用Proxy，如实现代理类增强行为，但是比较麻烦，需要先抽取接口，再用组合
```java
public class SecurityCheckBookService implements BookService {
    private final BookService target;

    public SecurityCheckBookService(BookService target) {
        this.target = target;
    }

    public void createBook(Book book) {
        securityCheck();
        target.createBook(book);
    }

    public void updateBook(Book book) {
        securityCheck();
        target.updateBook(book);
    }

    public void deleteBook(Book book) {
        securityCheck();
        target.deleteBook(book);
    }

    private void securityCheck() {
        ...
    }
}
```


# AOP
织入方式
- 编译期：编译期将切面逻辑织入字节码（AspectJ）
- 类加载器：自定义类加载器可以实现对字节码增强（比如加解密字节码）
- 运行时：通过动态代理在运行时生成代理类(Spring AOP)
    - 如果有接口，使用Java Proxy
    - 如果没有接口，使用CGLib

# Spring AOP 注解
- @Aspect 标识一个类是切面类
- @Pointcut 切入点
- @Before 在切入点之前执行
- @After 在切入点之后执行
- @Around 在切入点前后执行
- @AfterReturning 切入点方法return后执行
- @AfterThrowing 切入点方法抛出异常后执行
> 另外还有几个抽象术语
>  - Join Point 切入点对应的方法
>  - Advice 给方法添加的增强逻辑

### 语法
```java
// 对com.baeldung包下所有方法执行，都定义为切入点，切入点名称：repositoryClassMethods
@Pointcut("within(com.baeldung..*)")
public void repositoryClassMethods() {}

// 在切入点前后执行方法
@Around("repositoryClassMethods()")
public Object measureMethodExecutionTime(ProceedingJoinPoint pjp) throws Throwable {
    ...
}
```

### Pointcut
Pointcut以 Pointcut designator标识符（PCD）开始，PCD有以下几种
- execution：执行了什么方法
- within：在某个包下
    > `@Pointcut("@within(org.springframework.stereotype.Repository)")` 等同于
    > `@Pointcut("within(com.baeldung.spring.repository *)")`
- target：目标对象（用于JDK proxy的接口）
- this：目标对象（用于cglib代理的类）
- args：方法参数
- @target: 方法的类是否有某个注解
- @annotation：方法是否有某个注解
- @args：方法的参数是否有某个注解
> PCD也可以作为其它AOP注解的参数


# Spring AOP 使用
依赖
```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-aop</artifactId>
</dependency>
```

### 记录方法执行耗时（自定义注解）
自定义注解
```java
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface LogExecutionTime {

}
```
实现切面
```java
@Aspect
@Component
public class ExampleAspect {
    @Around("@annotation(LogExecutionTime)")
    public Object LogExecutionTime(ProceedingJointPoint jointPoint) throws Throwable {
        long start = System.currentTimeMillis();
        Object result = jointPoint.proceed();
        long end = System.currentTimeMillis();
        System.out.println("Execution Time: " + (end - start));
        return result;
    }
}
```
应用
```java
@LogExecutionTime
public void serve() throws InterruptedException {
    Thread.sleep(2000);
}
```

### 拦截方法
```java
@Aspect
@Component
public class AopAdvice {

    // 拦截controller包下任何方法（任何签名（public, protected...）, 任何返回类型，任何参数）
    @Pointcut("execution (* com.shangguan.aop.controller.*.*(..))")
    public void test() {

    }

    @Before("test()")
    public void beforeAdvice() {
        System.out.println("beforeAdvice...");
    }

    @After("test()")
    public void afterAdvice() {
        System.out.println("afterAdvice...");
    }

    @Around("test()")
    public void aroundAdvice(ProceedingJoinPoint proceedingJoinPoint) {
        System.out.println("before");
        try {
            proceedingJoinPoint.proceed();
        } catch (Throwable t) {
            t.printStackTrace();
        }
        System.out.println("after");
    }
}
```

# 参见
- [AOP - 廖雪峰](https://www.liaoxuefeng.com/wiki/1252599548343744/1266265125480448)
- [Pointcut - bealdung](https://www.baeldung.com/spring-aop-pointcut-tutorial)
- [AOP应用 - bealdung](https://www.baeldung.com/spring-aop-annotation)