#!/bin/sh
# jenkins-release.sh <待合并到master的测试分支> <git仓库地址>

if [ $1 == "origin/master" ]; then
    echo '=========> 不需要合并分支'
    exit 0;
fi

repoName=$(echo $2 | cut -d '/' -f2 | cut -d '.' -f1)
echo '=========> 仓库名: ' $repoName
echo '=========> 合并分支: ' $1 ' -> master'

# clone 远程分支
mkdir -p /home/git_repo/
cd /home/git_repo
git clone -b master $2
cd /home/git_repo/$repoName

# 合并分支
git merge $1
git push origin master:master

echo '=========> 开始打 Tag'

# 当前日期
today=$(date +%Y%m%d)
# 获取最近一次远程 master 提交的 commit id
latestCommitId=$(git rev-parse remotes/origin/master^{commit})
echo '===> 最后提交的commitId: ' $latestCommitId

# 获取分支所属
latestMergedBranch=$(git show $latestCommitId | grep 'Merge:' | cut -d' ' -f3) # 按空格截取，获取第三个字符串
lastestMergeRelatedBranches=$(git branch -r --contains $latestMergedBranch)
echo '===> 最后merge涉及的分支: ' $lastestMergeRelatedBranches

# 提交人信息设置
# name=`git show --pretty=%an $latestCommitId | awk 'NR==1{print}'`
# email=`git show --pretty=%ce $latestCommitId | awk 'NR==1{print}'`
# git config --global user.name $name
# git config --global user.email $email

# 确定 Tag 前缀
function getTagPrefix() {
    # 判断是否 hotfix 分支
    isHotfix=$(echo "${lastestMergeRelatedBranches}" | grep 'origin/hotfix')
    if [ -n "$isHotfix" ]; then
        echo 'hotfix'
    else
        echo 'release'
    fi
}
tagPrefix=$(getTagPrefix)
echo '===> tag前缀: ' $tagPrefix

# 确定完整 Tag
if [ $tagPrefix == "hotfix" ]; then
    # 获取最近一次创建的release标签
    latestReleaseTag=$(git for-each-ref --sort=-taggerdate --format "%(tag)" refs/tags | grep 'release' | head -n 1)
    # 获取最近一次生产版本的日期
    latestReleaseDate=$(echo "${latestReleaseTag}" | awk -F_ '{print substr($2,1,8)}')
    # 获取最近一次创建的hotfix标签
    latestHotfixTag=$(git for-each-ref --sort=-taggerdate --format "%(tag)" refs/tags | grep 'hotfix' | head -n 1)
    if [ $latestHotfixTag == "" ]; then
        # 如果不存在hotfix分支，那么说明第一次投产bug，直接返回版本号001
        hotFixVersion='001'
    else
        # 存在hotfix分支，判断hotfix的最后日期和release的最后日期，
        latestHotfixDate=$(echo "${latestReleaseTag}" | awk -F_ '{print substr($2,1,8)}')
        if [ $latestHotfixDate -eq $latestReleaseDate ]; then
            hotFixVersion=$(echo "${latestHotfixTag}" | awk -F_ '{print substr($3,1,3)+1}' | awk '{printf("%03d\n",$0)}')
            echo $hotFixVersion
        else
            hotFixVersion='001'
        fi
    fi
    currentTagName=$tagPrefix'_'$latestReleaseDate'_'$hotFixVersion
else
    currentTagName=$tagPrefix'_'$today
fi

# 创建标签
# prevTag=$(git tag --sort=-taggerdate  | grep -m1 '')
prevTag=$(git for-each-ref --sort=-taggerdate --format "%(tag)" refs/tags | head -n 1)
echo '===> 完整 Tag: ' $currentTagName
git tag -a $currentTagName -m '提交人: jenkins'
git push origin --tags
newTag=$(git tag -l | grep $currentTagName)
echo '===> Tag 打成功 : ' $newTag

# 创建标签完成后，删除对应的开发分支
echo '=========> 删除开发分支'

# 遍历分支
relatedBranches=$(git log ${prevTag}..${currentTagName} --oneline | grep 'Merge branch' | cut -d ' ' -f4 | sort --unique)
echo '===> 本次发布涉及的分支: ' $relatedBranches
for branch in $relatedBranches; do
    branch_type=$(echo $branch | grep '/' | cut -d '/' -f1)
    branch_name=$(echo $branch | grep '/' | cut -d '/' -f2)
    if [ "feature" == $branch_type ] || [ "hotfix" == $branch_type ]; then
        remove_branch_name=$branch_type"/"$branch_name
        echo '---> 删除: ' $remove_branch_name
        git push origin --delete $remove_branch_name
    else
        echo '---> 跳过: ' $branch_type"/"$branch_name
    fi
done

echo '=========> 删除本地库'
rm -rf /home/git_repo/
