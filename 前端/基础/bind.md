# 介绍
bind用于改变函数的this，并return一个新函数

# 实现
### 方案一
```javascript
Function.prototype.myBind = function(context) {
    let self = this;
    return function() {
        let args = Array.prototype.slice.call(arguments, 1);
        return self.apply(context, args);
    }
}
```

# 参见
- [JavaScript深入之bind的模拟实现 - github](https://github.com/mqyqingfeng/Blog/issues/12)