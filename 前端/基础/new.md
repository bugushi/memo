# 例子
```javascript
funciton Person(name, age) {
    this.name = name;
    this.age = age;
    this.say = function() {
        console.log(`name=${name}, age=${age}`);
    }
}

Person.prototype.color = 'yellow';
Person.prototype.sayBye = function() {
    console.log('bye');
}

let p = new Person('zhangsan', 18);
p.say();
console.log(p.color);
```

# new的过程
1、初始化新对象
```javascript
var obj = {};
```

2、绑定原型
```javascript
obj.__proto__ = Person.prototype;
```

3、绑定this，执行构造函数
```javascript
Person.call(obj, 'zhangsan', 18);
```

4、返回结果


# 参见
- [JS的new关键词都干了什么](https://segmentfault.com/a/1190000022296633)
