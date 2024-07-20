1. 查看CPU
```
# 13600kf 0-11 为大核（6核12线程），12-19为小核
$ sudo dnf install hwloc -y && lstopo --physical
```
2. 查看EU4当前使用核心
```
# 进程名称 eu4.exe 通过 top 查看
# 400 是 16 进制，转化为 2 进制后为 100 0000 0000, 右侧第一个 0 代表 cpu0， 所以此处 400 代表 cpu10
$ taskset -p $(pgrep eu4.exe)
pid 12909's current affinity mask: 400
```
3. 绑定 eu4 到大核
```
$ taskset -p --cpu-list 0,11 $(pgrep eu4.exe)
```


[How to Disable CPU Cores in Linux](https://www.baeldung.com/linux/disable-cpu-cores)
