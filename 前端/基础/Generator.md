# 介绍
```javascript
function* idMaker() {
    let index = 0;
    while(true) {
        let res = yield index++;
        console.log(res); // undefined || hello
    }
}

const gen = idMaker(); // Generator {}

gen.next() // {value: 0, done: false}
gen.next('hello') // {value: 1, done: false}
gen.return('foo') // {value: 'foo', done: true}
gen.next() // {value: undefined, done: true}
```
- 执行生成器不会执行生成器函数体的代码，只是获得一个遍历器
- 一旦调用 next，函数体就开始执行，一旦遇到 yield 就返回执行结果，暂停执行
- 第二次 next 的参数会作为第一次 yield 的结果传递给函数体，以此类推，所以第一次 next 调用的参数没用


# 实现 async 函数
```javascript
const getId = (id) => {
    return new Promise((resolve) => {
        setTimeout(() => {
            resolve(id + 1);
        }, 1000);
    })
};
function* idMaker() {
    let id = 0;
    while (true) {
        id = yield getId(id);
        console.log(id);
        // 1, 2, 3, ...
    }
}

function asyncFunc(generator) {
    const gen = generator();
    function next(data) {
        const { value, done } = gen.next(data);
        if (done) {
            return value;
        } else if (!(value instanceof Promise)) {
            next(value);
        } else {
            value.then((data) => next(data));
        }
    }
    next();
}
asyncFunc(idMaker);
```

# 参见
- [async/await原理 - segmentfault](https://segmentfault.com/a/1190000023442526)