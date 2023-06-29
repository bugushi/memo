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
