# for...in 与 for...of的区别
- for...in 遍历object的可枚举属性名，包括继承自原型的
- for...of，es6新语法，调用各类型对象自己实现的迭代器，输出value
```js
var arr = [3, 5, 7];
arr.foo = "hello";
    
for (var i in arr) {
  console.log(i); // "0", "1", "2", "foo"
}
    
for (var i of arr) {
  console.log(i); // "3", "5", "7"
  // 没有输出"hello"，因为array的迭代器忽略了非index属性
}
```

# 参见
- [What is the difference between ( for... in ) and ( for... of ) statements - stackoverflow](https://stackoverflow.com/questions/29285897/what-is-the-difference-between-for-in-and-for-of-statements) 