# 命令格式
```
ssh [OPTIONS] [-p PORT] [USER@]HOSTNAME [COMMAND]
```

# 参数
```
-L [BIND_ADDRESS:]PORT:HOST:HOSTPORT
	将本地主机的地址和端口接收到的数据通过安全通道转发给远程主机的地址和端口
-N
    不执行远程命令，用于转发端口。仅限协议第二版
-R [BIND_ADDRESS:]PORT:HOST:HOSTPORT
	将远程主机上的地址和端口接收的数据通过安全通道转发给本地主机的地址和端口
```

# 示例
```
ssh -NL 3000:localhost:3000 remote.example.com
ssh -R 9999:127.0.0.1:3000 remote.example.com

# 查看代理端口
ps aux | grep ssh
```

# 参见
[ssh 命令 - 腾讯云](https://cloud.tencent.com/developer/article/1594881)
