# call 与 apply
改变this
- fn.call(context, args1, args2, ...);
- fn.apply(context, args);

# call的模拟实现
思路
- 往context上增加fn方法
- 调用fn方法
- 删除fn方法

### 版本一
```javascript
Function.prototype.myCall = function(context) {
    context.fn = this; // this就是调用myCall的函数
    context.fn();
    delete context.fn;
}
```

### 版本二，增加入参
```javascript
Function.prototype.myCall = function(context) {
    context.fn = this; // this就是调用myCall的函数
    let args = Array.prototype.slice.call(arguments, 1);
    context.fn(...args);
    delete context.fn;
}
```

### 版本三，允许this传null，支持返回值
```javascript
Function.prototype.myCall = function(context) {
    let context = context || window;
    context.fn = this; // this就是调用myCall的函数
    let args = Array.prototype.slice(arguments, 1);
    let result = context.fn(...args);
    delete context.fn;
    return result;
}
```

# 参见
- [JavaScript深入之call和apply的模拟实现  - github](https://github.com/mqyqingfeng/Blog/issues/11)