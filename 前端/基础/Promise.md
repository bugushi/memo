# 手工实现
```javascript
class Promise {
    constructor(executor) {
        this.status = 'pending';
        this.onFulfilledCallbacks = [];
        this.onRejectedCallbacks = [];
        executor(this.#resolve.bind(this), this.#reject.bind(this));
    }

    then(onResolve, onReject) {
        switch (this.status) {
            case 'fulfilled':
                return new Promise((resolve, reject) => {
                    let res = onResolve(this.val);
                    if (res instanceof Promise) {
                        res.then(resolve, reject);
                    } else {
                        resolve(res);
                    }
                })
            case 'rejected':
                this.onRejectedCallbacks.forEach(fn => fn(reason))
            case 'pending':
                return new Promise((resolve, reject) => {
                    this.onFulfilledCallbacks.push((value) => {
                        let res = onResolve(value);
                        if (res instanceof Promise) {
                            res.then(resolve, reject);
                        } else {
                            resolve(res);
                        }
                    })
                })
        }
    }

    #resolve(val) {
        this.status = 'fulfilled'
        this.onFulfilledCallbacks.forEach(fn => fn(val))
    }

    #reject(reason) {
        this.status = 'rejected'
        this.onRejectedCallbacks.forEach(fn => fn(reason))
    }
}

new Promise((resolve, rejfect) => {
    setTimeout(() => {
        resolve(1)
    }, 2000);
}).then(val => console.log(val))
```

# 参见
- [简单实现Promise](https://imweb.io/topic/5bbc264b6477d81e668cc930)