# HTTPS握手流程
- 客户端发送hello给服务端
    - tls version
    - 加密算法
    - 压缩算法
- 服务端返回 serverHello
    - 证书
    - public key
    - sessionID
- 客户端访问CA（certificate authority）
    - 验证证书合法性
- 客户端发送shared secretKey给服务端
    - secretKey 使用第二步收到的publicKey加密
- 客户端发送finished消息
    - finished消息使用 secretKey 加密
- 服务端返回finished消息

# 参见
- [TLS protocol - youtube](https://www.youtube.com/watch?v=sEkw8ZcxtFk)