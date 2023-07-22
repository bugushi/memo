# 安装
- 安装完成后同意开启第三方源

# 安装nvidia驱动
- 把Gnome的窗口系统从wayland换成x11
  - 在登陆页面的又下角设置，完成后可以在系统设置的about中确认
- 关闭主板安全启动，进bios操作
- 安装驱动
  ```
  sudo dnf install akmod-nvidia
  sudo dnf install xorg-x11-drv-nvidia-cuda
  ```
- 重启
- 参考
  - https://zhuanlan.zhihu.com/p/635384972 

# gnome
- 缩放
  - 安装 gnome-tweak
    - 设置字体缩放1.5
- 插件（安装extension manager）
  - caffeine 阻止休眠
  - dash to dock 类似mac的dock栏
- 安装输入法
  - `sudo dnf install ibus-rime`
  - 注销重新登录
  - 设置中添加输入法
  - 输入状态下按 F4 切换简体

# 安装 IntelliJ
- 不要安装 flatpack 版，因为 flatpack 版运行在沙盒中，无法访问外部文件，因而无法配置 JDK
- 到官网下载 .tar.gz 文件
- `sudo tar xvzf idealC-2022.X.Y.tar.gz -C /opt`
- `/opt/idea-IC-VERSION/bin/idea.sh`
- 生成桌面快捷方式
- `Add JDK` -> `/usr/lib/jvm/java-17`
