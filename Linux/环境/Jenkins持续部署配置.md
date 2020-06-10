# 前置条件
部署有两个前提：
1. Jenkins可以连接git库，获取源码
2. Jenkins可以连接服务器，将打包好的代码推送到服务器

### 配置git库credential，用于访问git库
`Manage Jenkins` -> `Configure Credentials` -> 侧边`Credentials` -> `global` -> 侧边`Add Credentials`

### 安装Jenkins插件：`publish-over-ssh`，用于连接服务器
> https://plugins.jenkins.io/publish-over-ssh/

# 步骤
### 1、配置服务器连接
`Manage Jenkins` -> `Configure System` -> Add `SSH Server`

配置参考:
```
Name: TEST_192.168.0.11
Hostname: 192.168.0.11
Username: root
Remote Directory: /var/www/
Use password authentication: checked
Passphrase: password
```
添加完成后，点击 `Test Configuration`测试连接
### 2、配置项目
`New item` -> `Freestyle project`

##### General部分，勾选`This project is parameterized`，设置分支变量，推荐配置：
```
Name: BRANCH
Parameter Type: Branch or Tag
Default Value: origin/master
```

##### Source Code Management部分，指定git库地址


# 资料
### deploy.sh 部署jar包
目录 `/usr/local/bin`
```shell
#!/usr/bin/env bash
# 发布应用的基础路径

APP_NAME=$1
JAVA_OPT=" "
APP_BASE_PATH=/var/www/backend
APP_LOG_PATH=/var/www/backend/$APP_NAME/logs
#LOG_PATH=/var/www/backend/logs


#获取java参数
i=0
for arg in $@;do
    echo $i $arg
    if [ $i -gt 0 ]; then
        JAVA_OPT=$JAVA_OPT" "$arg
    fi
    i=`expr $i + 1`
done

#创建应用目录
if [ ! -d "$APP_BASE_PATH/$APP_NAME" ];then
    mkdir $APP_BASE_PATH/$APP_NAME
fi

#创建log目录
if [ ! -d "$APP_LOG_PATH" ];then
    mkdir $APP_LOG_PATH
fi

# 创建应用启动日志
if [ ! -f "$APP_LOG_PATH/application.log" ]; then
    touch $APP_LOG_PATH/application.log
fi

#停止原来的进程
pid=0
process=`ps aux | grep java | grep $APP_NAME`
echo "old process: "$process;
if [ -n "$process" ];then
    pid=`echo $process | cut -d \  -f 2`
    echo "old pid: "$pid
    sudo kill -9 $pid
fi

# 原发布文件的备份
if [ ! -d "$APP_BASE_PATH/$APP_NAME/bak" ]; then
    mkdir "$APP_BASE_PATH/$APP_NAME/bak"
fi

if [ -f "$APP_BASE_PATH/$APP_NAME/$APP_NAME.jar" ]; then
    mv $APP_BASE_PATH/$APP_NAME/$APP_NAME.jar $APP_BASE_PATH/$APP_NAME/bak/$APP_NAME".jar.bak_"$(date +%Y-%m-%d)
fi

# 复制新的发布文件
mv $APP_BASE_PATH/$APP_NAME*.jar $APP_BASE_PATH/$APP_NAME/$APP_NAME.jar

#启动应用程序
echo "start application: "$1" command: java "$JAVA_OPT" -jar "$APP_NAME".jar >"$APP_LOG_PATH"/application.log 2>&1 &"
cd $APP_BASE_PATH/$APP_NAME
nohup java $JAVA_OPT -jar ./$APP_NAME.jar >> $APP_LOG_PATH/application.log 2>&1 &

# 生成开机启动脚本并添加到开机启动列表
startCommand="nohup java $JAVA_OPT -jar $APP_BASE_PATH/$APP_NAME/$APP_NAME.jar >> $APP_LOG_PATH/application.log 2>&1 &"
sh /usr/local/bin/autostart.sh ${APP_NAME} "${startCommand}"
```

### autostart.sh 注册系统服务
目录 `/usr/local/bin`
```shell
#!/usr/bin/env bash
appName=$1
startCommand=$2
# 1.在/etc/rc.d/init.d目录下创建自启动脚本
echo -e "#!/bin/sh\n#chkconfig: 2345 80 90\n#description:开机自动启动的脚本程序" > /etc/rc.d/init.d/${appName}.sh

# 2.追加启动命令
echo "${startCommand}" >> /etc/rc.d/init.d/${appName}.sh

chmod 777 /etc/rc.d/init.d/${appName}.sh

# 3.添加到开机列表
cd  /etc/rc.d/init.d
chkconfig ${appName}.sh on
```
