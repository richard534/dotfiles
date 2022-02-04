#!/usr/bin/env bash

# git #########################################################################

parse_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Docker ######################################################################

# Docker containers list (with nicer format)
dps() { docker ps -a --format="table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Command}}\t{{.Status}}"; }

# Delete all images
drmi() { docker rmi -f $(docker images -q); }

# remove all stopped containers
drmc() { docker container rm $(docker container ls -aq); }

# Kill all running containers
dkillall() { docker kill $(docker ps -q); }

git_diff_folders() {
    git diff $1 --name-only | xargs -L1 dirname | uniq
}
