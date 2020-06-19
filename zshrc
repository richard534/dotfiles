export PYENV_ROOT="$HOME/.pyenv"

# Set PATH envar - a set of dirs where executable files are located. Dirs are Searched left to right
export PATH="$HOME/dotfiles/bin:$PYENV_ROOT/bin:$HOME/.vim/bundle/vim-superman/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# set default pager to less
export PAGER=less

# Set terminal colour scheme
export TERM='xterm-256color'

## oh-my-zsh config
# Set name of the theme to load.
ZSH_THEME="pygmalion"
# oh-my-zsh plugins
plugins=(git osx virtualenv)
# Set path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# java config
export JAVA_HOME=`/usr/libexec/java_home -v 1.8.0_202, x86_64` # latest java8 build

# sbt config
export SBT_OPTS="-XX:+CMSClassUnloadingEnabled -Xmx2G"

# set less envar (less options are taken from this envar to avoid typing each time)
# -R displays ANSI color escape sequences in "raw" form. (add colour to less)
# -S disables line wrapping. Side-scroll to see long lines.
# -X leaves file contents on the screen when less exits.
# -F makes less quit if the entire output can be displayed on one screen.
export LESS="-RSXF"

# fzf + ag configuration
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="rg --files --case-sensitive"

# 10ms for key sequences
KEYTIMEOUT=1

# vim-superman config
compdef vman="man"

# User defined alias's
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias man='vman'
alias emd='/Applications/Emacs.app/Contents/MacOS/Emacs --daemon'
alias em='emacsclient --no-wait'
alias emc='emacsclient -c --no-wait'
alias tree='tree -C'
alias info='info --vi-keys'
alias notify='terminal-notifier -title "Terminal" -message "donezo" -subtitle "donedonedone" -sound "default"'

# Setup "secret zsh conf"
# This conf file won't be uploaded to VCS
SECRET_CONF=~/.zshrc_local && test -f $SECRET_CONF && source $SECRET_CONF

## fzf config
# enable fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## pyenv config
# add 'pyenv init' to shell
if command -v pyenv 1>/dev/null 2>&1; then
 eval "$(pyenv init -)"
fi

## rbenv config
eval "$(rbenv init -)"
