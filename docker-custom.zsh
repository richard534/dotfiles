#!/usr/bin/env zsh

# Docker containers list (with nicer format)
dps() { docker ps -a --format="table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Command}}\t{{.Status}}"; }

# Delete all images
drmi() { docker rmi -f $(docker images -q); }

# remove all stopped containers
drmc() { docker container rm $(docker container ls -aq); }

# Kill all running containers
dkillall() { docker kill $(docker ps -q); }

