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
`vim ~/.bash_profile` | 设置终端代理

### SSH
key | action | 备注
-- | -- | --
`ssh-keygen` | 生成sshkey | 先进入~/.ssh目录

### 环境变量
```
# 系统级别
/etc/bashrc

# 用户级别
~/.bash_profile  # macOS默认
~/.bashrc # linux默认
```
```
# 示例 .bash_profile
export JAVA_HOME = /home/myuser/jdk1.7.0_03
export PATH = $JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

# 执行
source .bash_profile
```

### 终端
key | action | 备注
-- | -- | --
在`~/.zshrc`中增加`source ~/.bash_profile` | 读取bash shell的默认配置 | 
