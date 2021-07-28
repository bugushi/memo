# 自动登录
1、`ssh.exp`
```shell
#!/usr/bin/expect

set timeout 30
spawn ssh -p [lindex $argv 0] [lindex $argv 1]@[lindex $argv 2]
expect {
        "(yes/no)?"
        {send "yes\n";exp_continue}
        "password:"
        {send "[lindex $argv 3]\n"}
}
interact
```

2、编辑 iterm2 profile
- Name: 开发环境 10.1.2.3
- Badge: 开发环境 10.1.2.3
- Send text at start: `expect /Users/{user}/Documents/tools/ssh.exp 22 root 10.1.2.3 {password}
  > 密码如含有符号需转义 `\:`
