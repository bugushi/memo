# Functions
### path.join
```js
path.join('/foo', 'bar', 'baz/asdf', 'quux', '..');
// Returns: '/foo/bar/baz/asdf'
```

### path.resolve
get absolute path from relative path, get current file absolute path with empty argument.
```js
resolve('./another-file.js');
// Returns: '/home/user'
```

# Variables
### __dirname & __filename
if current file is `/home/user/my-module.js`
```
console.log(__dirname);
// Returns: '/home/user'

console.log(__filename);
// Returns: '/home/user/my-module.js'
```

