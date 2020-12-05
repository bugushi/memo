#!/bin/sh
# jenkins-release.sh <待合并到test*的开发分支> <test*分支> <git仓库地址>

repoName=$(echo $3 | cut -d '/' -f2 | cut -d '.' -f1)
echo '=========> 仓库名: ' $repoName
echo '=========> 合并分支: ' $1 ' -> ' $2

branchName=$(echo $2 | cut -d '/' -f2)
echo '---> 准备check分支: ' $branchName

# clone 远程分支
mkdir -p /home/git_repo/
cd /home/git_repo
git clone -b $branchName $3
cd $repoName

# 合并分支
git merge $1
git push origin $branchName:$branchName

echo '=========> 删除本地库'
rm -rf /home/git_repo/$repoName
