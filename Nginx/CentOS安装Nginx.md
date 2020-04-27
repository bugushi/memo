安装依赖
`sudo yum install epel-release`

安装
`sudo yum install nginx`

启动 Nginx
`sudo systemctl start nginx`

停止 Nginx
`sudo systemctl stop nginx`

重启 Nginx
`sudo systemctl restart nginx`

修改 Nginx 配置后，重新加载
`sudo systemctl reload nginx`

设置开机启动 Nginx
`sudo systemctl enable nginx`

关闭开机启动 Nginx
`sudo systemctl disable nginx`
