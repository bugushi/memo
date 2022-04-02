# Throttle
```javascript
function throttle(fn ,wait) {
    let prevTime = 0;
    return function() {
        if(Date.now() - prevTime > wait) {
            prevTime = Date.now();
            return fn.apply(this, arguments);
        }
    }
}
```

# Debounce
```javascript
function debounce(fn, wait) {
    let timer;

    return function() {
        let ctx = this;
        clearTimeout(timer);
        timer = setTimeout(function() {
            fn.apply(ctx, arguments);
        }, wait)
    }
}
```
如果需要返回值，改用throttle类似的计时法

# 参见
- [节流与防抖 - cnblogs](https://www.cnblogs.com/fsjohnhuang/p/4147810.html)