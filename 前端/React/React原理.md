# React组件
```javascript
const App = () => {
    return (
        <div>App Component</div>
    )
}
```
编译后
```javascript
const App = () => {
    return React.createElement("div", null, "App Component");
}
```

return的是什么
```javascript
{
    $$typeof: Symbol(react.element),
    key: null,
    props: {children: "App Componnet"},
    ref: null,
    type: "div"
}
```

# Diff（Reconciliation）
diff阶段，也叫reconciliation
- 如果元素类型改变，生成新的子树
- 如果元素属性改变，只更改对象属性
    > 通过key，尽量识别为属性改变


# Rendering
render由React-dom负责，在RN里则由RN负责。React本身只负责提供组件API和diff
### setState做了什么
```js
const instance = new Element();
instance.props = props;
instance.updater = ReactDomUpdater;

setState(partialState, callback) {
    this.updater.enqueueSetState(this, partialState, callback);
}
```
hooks中
```js
const React  = {
    __currentDispatcher = null;
    useState(initialState) {
        return React.__curentDispathcer.useState(initialState)
    }
}

const previousDispatcher = React.__currentDispatcher;
React.__currentDispatcher = ReactDOMDispatcher;
let result;
try {
    result = Component(props);
} finally {
    React.__currentDispatcher = previousDispatcher
}
```