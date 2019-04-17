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
git-squ() {
 if [ "$1" != "" ]
    then
      git reset --soft $1 &&
      git commit --edit -m"$(git log --format=%B --reverse HEAD..HEAD@\{1\})"
    else
     echo "Please provide SHA of commit to squash until"
   fi
}

# git reset hard && clean
git-reshardclean() {
	git reset --hard
	repoRootDir=$(git rev-parse --show-toplevel)
	cd $repoRootDir # go to root directory of repo
	git clean -df
	cd - # go back to dir cmd initially called from
}

# git goto root dir of repo
git-gotoroot() {
	repoRootDir=$(git rev-parse --show-toplevel)
	cd $repoRootDir # go to root directory of repo
}

# prune locally tracked branches that do not exist on remote anymore
# run "git fetch --prune" to delete references in /refs/remote that no longer exist on remote before running this command
# https://stackoverflow.com/questions/13064613/how-to-prune-local-tracking-branches-that-do-not-exist-on-remote-anymore
git-prune-local() {
	git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d
}

