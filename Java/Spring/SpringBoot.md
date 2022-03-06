# 启动原理
spring boot项目的启动类如下
```java
@SpringBootApplication
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
```
其中的`@SpringBootApplication`注解定义如下
```java
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Inherited
@SpringBootConfiguration
@EnableAutoConfiguration
@ComponentScan(excludeFilters = {
        @Filter(type = FilterType.CUSTOM, classes = TypeExcludeFilter.class),
        @Filter(type = FilterType.CUSTOM, classes = AutoConfigurationExcludeFilter.class) })
public @interface SpringBootApplication {
...
}
```
其中有三个注解比较重要
- @Configuration（@SpringBootConfiguration点开查看发现里面还是应用了@Configuration）
- @EnableAutoConfiguration
- @ComponentScan

### @Configuration
用于标识当前类为JavaConfig配置类，和spring中的xml配置作用相同
```java
@Configuration
public class MockConfiguration{
    @Bean
    public MockService mockService(){
        return new MockServiceImpl(dependencyService());
    }
    
    @Bean
    public DependencyService dependencyService(){
        return new DependencyServiceImpl();
    }
}
```

### @ComponentScan
用于指定扫描的包，把其中表示了@Component的类加入spring容器中（包括@Controller等）
```java
@ComponentScan(basePackages={"com.hrtps.common.base.monitor",  "com.hrtps.common.cache"})
```
> 所以SpringBoot的启动类最好是放在root package下，因为默认不指定basePackages。

### @EnableAutoConfiguration
自动配置引入的三方bean，如，我们引入了`spring-boot-starter-web`，则 springboot 会自动配置 `Tomcat` 和 `Spring MVC`
```java
// 源码
@AutoConfigurationPackage
@Import(AutoConfigurationImportSelector.class)
public @interface EnableAutoConfiguration {

	String ENABLED_OVERRIDE_PROPERTY = "spring.boot.enableautoconfiguration";

	/**
	 * 排除自动配置 
	 * Exclude specific auto-configuration classes such that they will never be applied.
	 * @return the classes to exclude
	 */
	Class<?>[] exclude() default {};

	/**
	 * 排除自动配置
	 * Exclude specific auto-configuration class names such that they will never be
	 * applied.
	 * @return the class names to exclude
	 * @since 1.3.0
	 */
	String[] excludeName() default {};

}
```
- 使用@Import导入一个类 AutoConfigurationImportSelector.class, 这个类是DefferredImportSelector的实现类，也是ImportSelector的实现类
- Spring在处理@Import注解的时候，如果它导入的是ImportSelector的实现类，则会调用它的 selectImports方法
- AutoConfigurationImportSelector 的 selectImports方法，从spring.factories(一般是三方包)中读取key为org.spring.framework.autoconfig.EnableAutoConfiguration的属性，将其值作为配置类处理


# 参见
- [Spring Boot启动原理 - 嘟嘟独立技术](http://tengj.top/2017/03/09/springboot3/)
- [@EnableAutoConfiguration的作用 - 博客园](https://www.cnblogs.com/kevin-yuan/p/13583269.html)
- [Spring boot启动流程 - github.io](https://liuyazong.github.io/spring-boot-source-code/)