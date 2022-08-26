# Could not resolve placeholder 'xxx' in value "${xxx}"
- 检查是否启动了对应环境的配置文件
- add `-Dspring.profiles.active=dev` to VM Options
- [参见 stackoverflow](https://stackoverflow.com/questions/39738901/how-do-i-activate-a-spring-boot-profile-when-running-from-intellij)
