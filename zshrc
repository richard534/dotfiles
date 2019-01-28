# Set terminal colour scheme
export TERM='xterm-256color'

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="pygmalion"

# oh-my-zsh plugins
plugins=(git osx virtualenv)

# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin"

# Load oh-my-ssh
source $ZSH/oh-my-zsh.sh

# 10ms for key sequences
KEYTIMEOUT=1

# User defined alias's
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias python='python3'
alias pip='pip3'

# fzf + ag configuration
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

# java config
export JAVA_HOME=`/usr/libexec/java_home -v 1.8.0_202, x86_64` # latest java8 build

# source local zshrc (for secret conf)
if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

