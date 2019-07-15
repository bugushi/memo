# Linux

### 文件
key | action
-- | --
`zip -r dist.zip source` | 将source目录压缩为dist.zip
`unzip test.zip -d tmp/` | 解压文件, -d指定目录

### 网络
key | action
-- | --
`lsof -i :3000` | 查看3000端口占用
`kill -9 <PID>` | 杀端口
`export http_proxy=http://127.0.0.1:1080` | 设置终端代理
