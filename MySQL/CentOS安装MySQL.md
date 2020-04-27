# 系统
CentOS 7.6 64位

# MySQL
RPM方式安装，版本5.7
### 1、删除已安装的MySQL

##### 检查MySQL
`shell> rpm -qa|grep mysql`

##### 删除MySQL
如果不存在（上面检查结果返回空）则跳过步骤
`shell> rpm -e --nodeps xxx`

### 2、下载MySQL安装包
到[https://dev.mysql.com/downloads/mysql/]选择对应安装包

`wget https://cdn.mysql.com//Downloads/MySQL-5.7/mysql-5.7.29-1.el7.x86_64.rpm-bundle.tar`

### 3、安装MySQL
解压
```
shell> tar -xvf mysql-5.7.29-1.el7.x86_64.rpm-bundle.tar
```
在tar解压之后的rpm包所在目录安装，否则变成yum在线安装（默认MariaDB）
```
yum install mysql-community-{server,client,common,libs}-*
```
### 4、操作
启动
```
shell> sudo systemctl start mysqld.service
```
查看状态
```
shell> sudo systemctl status mysqld.service
```
停止
```
shell> sudo systemctl stop mysqld.service
```
重启
```
shell> sudo systemctl restart mysqld.service
```

### 5、修改密码
##### 初始密码
MySQL第一次启动后会创建超级管理员账号`root@localhost`，初始密码存储在日志文件中：
```
shell> sudo grep 'temporary password' /var/log/mysqld.log
```
##### 修改默认密码
```
mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'Hrtps@123';
```

### 6、允许root远程访问
```
mysql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'Hrtps@123' WITH GRANT OPTION;
mysql> FLUSH PRIVILEGES;
```
### 7、设置编码
编辑`/etc/my.cnf`，添加如下配置
```
[mysqld]
character-set-server=utf8mb4
collation-server=utf8mb4_unicode_ci
init_connect='SET NAMES utf8mb4'
skip-character-set-client-handshake=false

[mysql]
default-character-set=utf8mb4
```
重启`systemctl restart mysqld`
### 8、设置开机启动
```
shell> systemctl enable mysqld
shell> systemctl daemon-reload
```
### 9、开启防火墙允许远程连接
查看防火墙
```
firewall-cmd --list-all
```
开放3306端口
```
firewall-cmd --permanent --add-port=3306/tcp
```
重启防火墙
```
service firewalld restart
```
查看3306端口是否开放
```
firewall-cmd --query-port=3306/tcp
```
