# CSS代码片段

### 单行省略
```css
overflow: hidden;
text-overflow: ellipsis;
white-space: nowrap;
```


### 多行省略
仅支持webkit内核
```css
overflow : hidden;
text-overflow: ellipsis;
display: -webkit-box;
-webkit-line-clamp: 2;
-webkit-box-orient: vertical;
```
