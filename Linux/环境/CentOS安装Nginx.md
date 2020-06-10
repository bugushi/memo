### 安装
安装前置依赖
```
sudo yum install epel-release
```
```
sudo yum install nginx
```

### 设置开机启动
开启
```
sudo systemctl enable nginx
```
关闭
```
sudo systemctl disable nginx
```

### 命令
- `sudo systemctl start nginx`
- `sudo systemctl stop nginx`
- `sudo systemctl restart nginx`
- `sudo systemctl reload nginx` 修改 Nginx 配置后，重新加载


