# Lambda表达式

### 取代某些匿名内部类
无参函数简写
```java
// JDK7 匿名内部类写法
new Thread(new Runnable(){// 接口名
	@Override
	public void run(){// 方法名
		System.out.println("Thread run()");
	}
}).start();

// JDK8 Lambda表达式写法
new Thread(
		() -> System.out.println("Thread run()")// 省略接口名和方法名
).start();

// JDK8 Lambda表达式代码块写法
new Thread(
        () -> {
            System.out.print("Hello");
            System.out.println(" Hoolee");
        }
).start();
```

带参函数的简写
```java
// JDK7 匿名内部类写法
List<String> list = Arrays.asList("I", "love", "you", "too");
Collections.sort(list, new Comparator<String>(){// 接口名
    @Override
    public int compare(String s1, String s2){// 方法名
        if(s1 == null)
            return -1;
        if(s2 == null)
            return 1;
        return s1.length()-s2.length();
    }
});

// JDK8 Lambda表达式写法
List<String> list = Arrays.asList("I", "love", "you", "too");
Collections.sort(list, (s1, s2) ->{// 省略参数表的类型
    if(s1 == null)
        return -1;
    if(s2 == null)
        return 1;
    return s1.length()-s2.length();
});
```

### 简写的依据
- 能够使用Lambda的依据是必须有相应的函数接口（函数接口，是指内部只有一个抽象方法的接口），也就是说你并不能在代码的任何地方任性的写Lambda表达式。
- Lambda表达式另一个依据是类型推断机制，在上下文信息足够的情况下，编译器可以推断出参数表的类型，而不需要显式指名。

Lambda表达更多合法的书写形式如下：
```java
// 无参函数的简写
Runnable run = () -> System.out.println("Hello World");

// 有参函数的简写、及类型推断
ActionListener listener = event -> System.out.println("button clicked");

// 类型推断
BinaryOperator<Long> add = (Long x, Long y) -> x + y;
BinaryOperator<Long> addImplicit = (x, y) -> x + y;
```

### 自定义函数接口
自定义函数接口很容易，只需要编写一个只有一个抽象方法的接口即可。
```java
// 自定义函数接口
@FunctionalInterface
public interface ConsumerInterface<T>{
	void accept(T t);
}

```
上面代码中的@FunctionalInterface是可选的，但加上该标注编译器会帮你检查接口是否符合函数接口规范。就像加入@Override标注会检查是否重载了函数一样。
有了上述接口定义，就可以写出类似如下的代码：
```java
ConsumerInterface<String> consumer = str -> System.out.println(str);
```