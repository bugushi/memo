软件 | 版本
-- | --
CentOS | 7.6 64位
open-JDK | 11

# 安装
#### 1、查找可安装项 
`yum list java*`

> 区分jre和jdk
> jdk | jre
> -- | --
> java-11-openjdk-devel.x86_64 | java-11-openjdk.x86_64

#### 2、安装
```
yum install java-11-openjdk-devel.x86_64
```

#### 3、添加环境变量（备用）
```
vi /etc/profile
```
增加
```
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.171-8.b10.el6_9.x86_64
export CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export PATH=$PATH:$JAVA_HOME/bin
```
使生效
```
source /etc/profile
```

#### 4、查看版本 
`java -version`
