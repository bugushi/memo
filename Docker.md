# 命令

命令 | 说明 | 备注
-- | -- | --
`docker run --name <container> -it <image>` | 以<image>镜像启动容器，命名为<container> | `-it` is short for `--interactive` + `--tty`<br>when you docker run with this command.. it would take you straight inside of the container,, <br><br>where `-d` is short for `--detach` <br>which means you just run the container and then detach from it so basically you run container in the background..
`docker exec -it <container> bash` | 在运行的容器中用bash执行命令 | 
`docker attach --sig-proxy=false <container>` | 进入正在运行的容器（不会新开终端）| `--sig-proxy`防止在终端`ctrl + c`导致容器终止运行
