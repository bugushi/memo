# 介绍
新项目第一次merge，git会给一个warning，提示我们选择merge strategy
<img src="https://tschuermansbe.files.wordpress.com/2020/11/gitpull.png?w=2048" height="400" />

假设当前在feature分支，要合并master分支的代码：
type | desc | isDefault
-- | -- | --
merge | 在feature分支增加merge commit | default
rebase | 将master分支的commit，变基到feature分支上 | 
fast-forward | 如果master分支有更新，而feature分支还没有commit过，使用fast-forward可以避免一次merge commit；<br> 如果不符合这个条件，会回退到merge策略 <br> 如果使用`ff only`，则拒绝合并

# merge
<img src="https://wac-cdn.atlassian.com/dam/jcr:c6db91c1-1343-4d45-8c93-bdba910b9506/02%20Branch-1%20kopiera.png?cdnVersion=389" height="400" />

# rebase
<img src="https://wac-cdn.atlassian.com/dam/jcr:4e576671-1b7f-43db-afb5-cf8db8df8e4a/01%20What%20is%20git%20rebase.svg?cdnVersion=389" height="400" />

# fast-forward
<img src="https://wac-cdn.atlassian.com/dam/jcr:d90f2536-7951-4e5e-ab79-f45a502fb4c8/03-04%20Fast%20forward%20merge.svg?cdnVersion=389" height="800" />

# 参见
- [git fast-forward](https://www.atlassian.com/git/tutorials/using-branches/git-merge)
- [git rebase](https://www.atlassian.com/git/tutorials/rewriting-history/git-rebase)
- [一文读懂rebase和fast-forward](https://blog.csdn.net/weixin_43459866/article/details/110118787)
