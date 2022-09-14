# Functions
### path.join()
```js
path.join('/foo', 'bar', 'baz/asdf', 'quux', '..');
// Returns: '/foo/bar/baz/asdf'
```

### path.resolve()
get absolute path from relative path, get current file absolute path with empty argument.
```js
resolve('./another-file.js');
// Returns: '/home/user'
```

### process.cwd()
return the folder where `node` run from
```shell
$ cd /home
$ node user/my-module.js
// return '/home'

$ cd /home/user
$ node my-module.js
// return '/home/user'

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

### NODE_PATH
tell node where to require file
```json
{
  "scripts": {
    "start": "NODE_PATH=/var/www/lib node app.js"
  }
}
```
then
```js
require('module2/component.js');
// looks for /var/www/lib/module2/component.js
```

# FAQ
### fs.readFileSync(path) the argument path is relative to the directory where `node` is invoked from?
Yes, use `path.resolve(__dirname, "target_file_relative_path");` to get absolute path of the target file.

