# JWT base64 decode error: atob failed
- 服务端encode中包含了非AscII字符，导致encode出来的string包含非标准的"-"和"_"字符，前端需要处理一下base64 string，使其标准化
  - https://stackoverflow.com/questions/5234581/base64url-decoding-via-javascript
- 或者在前端使用 [jwt-decode](https://github.com/auth0/jwt-decode)
