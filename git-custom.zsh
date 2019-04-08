#!/usr/bin/env zsh

# git reset to common ancestor of head commit -- origin/master
gitrca() {
  common=$(git merge-base HEAD origin/master)
  git reset $common
}

# git reset to HEAD@{1} (last head position)
# used in conjunction with gitrca to reset to latest commit
gitrh1() {
  git reset HEAD@{1}
}

# git reset to origin version of current branch
gitro() {
  HEADBRANCH=$(git rev-parse --abbrev-ref HEAD)
  git reset origin/$HEADBRANCH
}

# git squash from current branch up until provided commit
# and concatenate log messages
gitsqu() {
 if [ "$1" != "" ]
    then
      git reset --soft $1 &&
      git commit --edit -m"$(git log --format=%B --reverse HEAD..HEAD@\{1\})"
    else
     echo "Please provide SHA of commit to squash until"
   fi
}

# git reset hard && clean
gitreshardclean() {
	git reset --hard
	repoRootDir=$(git rev-parse --show-toplevel)
	cd $repoRootDir # go to root directory of repo
	git clean -df
	cd - # go back to dir cmd initially called from
}

