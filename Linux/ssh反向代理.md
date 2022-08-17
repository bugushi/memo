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
    不进入ssh，让如reverse proxy保持在前台；去掉-N则会登进服务器，且reverse proxy在后台运行
-R [BIND_ADDRESS:]PORT:HOST:HOSTPORT
	将远程主机上的地址和端口接收的数据通过安全通道转发给本地主机的地址和端口
```

# 示例
```
ssh -NL 3000:localhost:3000 remote.example.com
ssh -R 9999:127.0.0.1:3000 remote.example.com

# 在local查看代理端口
ps aux | grep ssh
# 在remote查看reverse进程
lsof -i
```

# 参见
[ssh 命令 - 腾讯云](https://cloud.tencent.com/developer/article/1594881)
