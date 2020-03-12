# Node.js

### 除了 require 时可以用相对路径，其它时候必须用 `path.join`, `__dirname`, `path.resolve`等

https://github.com/imsobear/blog/issues/48

### process.cwd()指执行node命令时的文件夹地址，__dirname指文件静态地址

### `Express`中`res.send()` 自动为各种返回类型设置对应的 `content-type` ,  `res.json()` 是 `res.send()` 的子集，没有必要特别使用

> https://blog.fullstacktraining.com/res-json-vs-res-send-vs-res-end-in-express/
