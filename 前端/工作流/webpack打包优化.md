# 分析
- speed-measure-webpack-plugin
- perf_hooks
- webpack-bundle-analyzer

手段
- 移除检查代码
- CDN
- 升级插件

# CDN
将常用库改为cdn引入

在public/index.html中添加
```html
<link
    href="//cdn.bootcdn.net/ajax/libs/antd/4.3.4/antd.min.css"
    rel="stylesheet"
/>

<script src="//cdn.bootcdn.net/ajax/libs/react/16.12.0/umd/react.production.min.js"></script>

<script src="//cdn.bootcdn.net/ajax/libs/react-dom/16.12.0/umd/react-dom.production.min.js"></script>

<script src="//cdn.bootcdn.net/ajax/libs/redux/4.0.5/redux.min.js"></script>

<script src="//cdn.bootcdn.net/ajax/libs/lodash.js/4.17.15/lodash.min.js"></script>

<script src="//cdn.bootcdn.net/ajax/libs/moment.js/2.27.0/moment.min.js"></script>
<script src="//cdn.bootcdn.net/ajax/libs/moment.js/2.27.0/locale/zh-cn.min.js"></script>

<script src="//cdn.bootcdn.net/ajax/libs/antd/4.3.4/antd-with-locales.min.js"></script>
```

webpack
```js
const useExternal = config => {
    config.externals = {
        react: 'React',
        'react-dom': 'ReactDOM',
        redux: 'Redux',
        lodash: '_',
        moment: 'moment',
        'moment/locale/zh-cn': 'moment.locale',
        antd: 'antd',
    };

    return config;
};

module.exports = override(useExternal);
```

# 移除检查代码
- Package.json校验
- TS配置校验
- 入口文件检测
- browserList校验
- 文件大小校验

# 参照
- [react-scripts流程及源码分析 - 掘金](https://juejin.cn/post/6844903951893004296)