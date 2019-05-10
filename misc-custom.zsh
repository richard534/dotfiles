#!/usr/bin/env zsh

# git reset to common ancestor of head commit -- origin/master
prettyjson() {
	if [ "$1" != "" ]; then
		cat $1 | jq | vim -c 'set syntax=json' -
	else
		echo "Please provide filename to prettyify"
	fi
}
