
# 是同步还是异步
- 在react可控制的范围，是异步批量处理的，如合成事件，生命周期函数
    > react会在这些地方将标志位`isBatchingUpdates`设为true 
- 在原生js控制范围是同步处理的，如原生事件，定时器回调，ajax回调等
    > 可使用`unstable_batchedUpdates`包裹，强制同步更新

# 原理
![](../../images/frontend/setState.awebp)

# 自己实现
### 简单的同步更新
```javascript
setState( stateChange ) {
    //合并接收到的state||stateChange改变的state（setState接收到的参数）
    Object.assign( this.state, stateChange );
    renderComponent( this );//调用render渲染组件
}
```

### 添加队列
```javascript
//创建一个队列
const queue = [];
const renderQueue = [];
/**
*该方法用于保存传过来的一个个state和其对应要更新的组件，但是并不更新
*而是先放入该队列中等待操作
*/
function enqueueSetState( stateChange, component ) {
    // 异步执行
    // 也可使用setTimeout，requestAnimationFrame等
    if (queue.length === 0) {
        Promise.resolve().then(flush)
    }

    queue.push({
        stateChange,
        component
    });

    // 如果renderQueue里没有当前组件，则添加到队列中
    if ( !renderQueue.some( item => item === component ) ) {
        renderQueue.push(component);
    }
}

setState( stateChange ) {
    enqueueSetState(stateChange, this);//
}
```

### 清空队列
```javascript
/**
*该方法用于清除队列内容
*/
function flush() {
    let item;
    // 遍历
    while( item = setStateQueue.shift() ) {

        const { stateChange, component } = item;

        // 如果stateChange是一个方法，也就是setState的第二种形式
        if ( typeof stateChange === 'function' ) {
            Object.assign(component.state, stateChange(component.prevState, component.props));
        } else {
            // 如果stateChange是一个对象，则直接合并到setState中
            Object.assign(component.state, stateChange);
        }

        component.prevState = component.state;
    }

    // 渲染每一个组件
    while(component = renderQueue.shift()) {
        renderComponent(component);
    }
}
```

# 参见
- [setState 是同步还是异步 - 掘金](https://juejin.cn/post/6996846391108567077)
- [react setState核心实现原理 - 知乎](https://zhuanlan.zhihu.com/p/44537887)