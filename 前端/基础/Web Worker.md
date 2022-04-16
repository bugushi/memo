# worker
概括地说，Web Worker，Service Worker和Worklet都是在与浏览器页面线程不同的线程上运行的脚本。它们的不同之处在于它们的使用位置以及启用这些用例所必须具备的功能。
- worklet与浏览器的渲染管道挂钩，使我们能够对浏览器的渲染过程（例如样式和布局）进行低级访问。
- service worker是浏览器和网络之间的代理。通过拦截文档发出的请求，service worker可以将请求重定向到缓存，从而实现脱机访问。
- Web Worker是通用脚本，使我们能够从页面线程上卸载处理器密集型worker。

dimention | Web Workers  | Service Workers  
--|--|--
 Instances    | Many per tab | One for all tabs 
 Lifespan     | Same as tab  | Independent      
 Intended use | Parallelism  | Offline support  

# 介绍
- 用于执行耗时任务
  - 图像处理
- 主线程创建，后台执行
- 执行完毕须关闭

# 限制
- workder线程运行的脚本，须同源
- 不能操作dom或者读取window对象，不能读取本地文件，可发送xhr请求
    > 有很多window下的对象可使用，如navigator，location等，详见：https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Functions_and_classes_available_to_workers    
- 和主线程通信依靠 postMessage或者indexDB等

# 使用
### 主线程
初始化
```javascript
// 文件必须使用网络地址
var worker = new Worker('work.js');
```

发送消息
```javascript
worker.postMessage('Hello World');
worker.postMessage({method: 'echo', args: ['Work']});
```

监听消息
```javascript
worker.onmessage = function (event) {
  console.log('Received message ' + event.data);
  doSomething();
}

function doSomething() {
  // 执行任务
  worker.postMessage('Work done!');
}
```

关闭
```javascript
worker.terminate();
```

### worker线程
接收消息
```javascript
// self相当于worker线程的window
self.addEventListener('message', function (e) {
  self.postMessage('You said: ' + e.data);
}, false);
```
```javascript
self.onmessage(function (e) {
  self.postMessage('You said: ' + e.data);
})
```

发送消息
```javascript
self.postMessage('WORKER STARTED');
```

关闭
```javascript
self.close();
```

# 大对象传输性能问题
如果要在主线程读取文件，worker线程负责解析，那么在主线程和worker线程之间copy对象会非常耗时

例如
```javascript
var data = new Uint8Array(500 * 1024 * 1024);
self.postMessage(data);
```
浏览器测试结果
浏览器	| 传输耗时	| 最终内存
-- | -- | -- 
Chrome	| 149ms	| 1042MB
Edge	| 455ms	| 1048MB
Firefox	| 380ms	| 1079MB
> 传输后浏览器进程内存增长到了1GB，因为data对象被复制了一份传输到主进程，传输后我们在worker进程和主进程都可以访问到这500MB的数据。

### 优化
使用Transferable，允许传递引用地址，不过传递后只有一个线程可以持有，比如主线程传输给worker线程，则主线程不再可访问
```javascript
var data = new Uint8Array(500 * 1024 * 1024);
// buffer, 表示由TypedArray在构造期间引用的ArrayBuffer，而ArrayBuffer则代表原始数据
self.postMessage(data, [data.buffer]); 
```
浏览器测试结果
浏览器	| 传输耗时	| 最终内存
-- | -- | -- 
Chrome	| 1ms	| 531MB
Edge	| 0ms	| 537MB
Firefox	| 0ms	| 549MB
> ArrayBuffer、MessagePort 和 ImageBitmap 实现了Transferable接口。

# 参见
- [深入分析Web worker, Service worker, Worklet - 简书](https://www.jianshu.com/p/e2cdc78ff47c)
- [What can service workers do that web workers cannot? - stackoverflow](https://stackoverflow.com/questions/38632723/what-can-service-workers-do-that-web-workers-cannot)
- [web worker 使用 tranferable](https://joji.me/zh-cn/blog/performance-issue-of-using-massive-transferable-objects-in-web-worker/)
- [Transferable - MDN](https://developer.mozilla.org/zh-CN/docs/Web/API/Transferable)