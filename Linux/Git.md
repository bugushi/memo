# Git

> Git飞行规则：[https://github.com/k88hudson/git-flight-rules/blob/master/README_zh-CN.md](https://github.com/k88hudson/git-flight-rules/blob/master/README_zh-CN.md)

### 设置
key | action
-- | --
`git config --global user.name :name` | 设置用户名
`git config --global user.email :email` | 设置email
`git config --global core.ignorecase false` | 强制识别文件夹大小写

### 查看
key | action
-- | --
`cat ~/.gitconfig` | 查看全局git配置文件
`git status` | 
`git log` | 查看commit历史
`git log --all` | 查看所有分支commit历史
`git log :file_name` | 查看文件commit历史
`git show` | 查看最近commit明细
`git show :commit_hash` | 查看某次commit明细
`git show :file_name` | 查看文件最近commit明细
`git diff` | 查看工作区更改明细
`git diff branch1 branch2 --stat` | 查看两个分支的文件差异
`git diff branch1 branch2` | 查看两个分支的详细差异

### 暂存 
key | action
-- | --
`git stash` | 
`git stash apply` |
`git stash list` |
`git stash clear` |

## 回滚 
key | action
-- | --
`git checkout -- :file` | 放弃工作区更改
`git checkout -- .` | 放弃工作区全部更改
`git commit --amend` | 修改最近一次commit信息
`git reset` | 取消add
`git reset --soft HEAD` | 取消commit，比如需要重填commit信息
`git reset HEAD` | 取消commit和add，重新提交代码
`git reset --hard HEAD` | 取消commit、add和工作区修改，恢复和远程一致
`git reset --hard :commit_hash` | 恢复到某一提交版本

### 分支
key | action
-- | --
`git branch -r` | 查看所有远程分支
`git checkout :branch_name` | 检出分支
`git checkout -b :new_branch_name` | 从当前分支拉出新本地分支
`git push --set-upstream origin :branch_name` | 提交本地新分支
`git branch -d :local_branch_name` | 删除本地分支
`git push origin --delete :branch_name` | 删除远程分支
`git merge :branch_name` | 合并分支到当前

### Tag
key | action 
-- | --
`git tag -a v1.0 -m '端午节发布'` | 新建tag
`git push --tags` | 提交tag
`git merge tag_name` | merge到tag

### 查看进阶
key | action
-- | --
`git log --oneline | grep -m1 "into 'master'"` | 查看第1个merge到master的提交，m2查看前两个
`git log hotfix_20201204_009..release_20201205 --oneline | grep Merge` | 查看两个tag之间的提交记录
`git tag --sort=-taggerdate` | 查看所有tag按日期排列
