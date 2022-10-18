
# 命令
- docker network ls 在宿主机查看网络
  - will be `bridge` if use default network mode
- docker -p
  - 访问宿主机的127.0.0.1:80 可以进入container的80端口
    ```
    docker run -d -p 127.0.0.1:80:80 nginx:alpine
    ```
