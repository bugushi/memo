软件 | 版本
-- | --
CentOS | 7.6 64位
open-JDK | 11


# 前置
安装前检查系统是否已安装open-jdk
```
rpm -qa |grep jdk
```

# 安装
#### 1、下载依赖
```
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
```

#### 2、导入密钥
```
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
```

#### 3、安装
```
yum install jenkins
```

#### 4、 查找jenkins安装路径
```
rpm -ql jenkins
```

> jenkins相关目录释义：
> - `/usr/lib/jenkins/`：jenkins安装目录，war包会放在这里
> - `/etc/sysconfig/jenkins`：jenkins配置文件，“端口”，“JENKINS_HOME”等都可以在这里配置。
> - `/var/lib/jenkins/`：默认的JENKINS_HOME。
> - `/var/log/jenkins/jenkins.log`：jenkins日志文件。

# 初始化 Jenkins 服务器
#### 1、 编辑 Jenkins 配置文件
> 为了不因为权限出现各种问题，这里直接修改用户为root。

`vim /etc/sysconfig/jenkins`
```
$JENKINS_USER="root"
```

#### 2、后台启动Jenkins
```
java -jar jenkins.war --http2Port=8080 &
```

#### 3、浏览到 `http://localhost:8080`，并等待 解锁 Jenkins 页面出现
![jenkins](https://www.jenkins.io/zh/doc/book/resources/tutorials/setup-jenkins-01-unlock-jenkins-page.jpg)

#### 4、从 Jenkins 控制台日志输出中，复制自动生成的字母数字密码（在两组星号之间）。
![密码](https://www.jenkins.io/zh/doc/book/resources/tutorials/setup-jenkins-02-copying-initial-admin-password.png)

#### 5、安装推荐插件，创建管理员用户

