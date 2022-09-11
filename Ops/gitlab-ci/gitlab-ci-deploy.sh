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
