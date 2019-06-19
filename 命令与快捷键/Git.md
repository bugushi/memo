# Git

> Git飞行规则：[https://github.com/k88hudson/git-flight-rules/blob/master/README_zh-CN.md](https://github.com/k88hudson/git-flight-rules/blob/master/README_zh-CN.md)

分类 | 命令 | 说明
-- | -- | --
设置 | `git config --global user.name :name` | 设置用户名
| | `git config --global user.email :email` | 设置email
| | `git config --global core.ignorecase false` | 强制识别文件夹大小写
查看 | `cat ~/.gitconfig` | 查看全局git配置文件
|| `git status` | 
||`git log` | 查看commit历史
||`git log :file_name` | 查看文件commit历史
||`git show` | 查看最近commit明细
||`git show :commit_hash` | 查看某次commit明细
||`git show :file_name` | 查看文件最近commit明细
||`git diff` | 查看工作区更改明细
暂存 | `git stash` | 
||`git stash apply` |
||`git stash list` |
||`git stash clear` |
回滚 | `git checkout -- :file` | 放弃工作区更改
|| `git checkout -- .` | 放弃工作区全部更改
|| `git reset --soft HEAD` | 取消commit，比如需要重填commit信息
|| `git reset HEAD` | 取消commit和add，重新提交代码
|| `git reset --hard HEAD` | 取消commit、add和工作区修改，恢复和远程一致
|| `git reset --hard :commit_hash` | 恢复到某一提交版本
分支 | `git branch -r` | 查看所有远程分支
|| `git checkout :branch_name` | 检出分支
|| `git checkout -b :new_branch_name` | 从当前分支拉出新本地分支
|| `git push --set-upstream origin :branch_name` | 提交本地新分支
|| `git branch -d :local_branch_name` | 删除本地分支
|| `git push origin --delete :branch_name` | 删除远程分支
|| `git merge :branch_name` | 合并分支到当前

