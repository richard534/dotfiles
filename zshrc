# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="pygmalion"

# oh-my-zsh plugins
plugins=(git osx)

# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin"

# Load oh-my-ssh
source $ZSH/oh-my-zsh.sh

# User defined alias's
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias python='python3'
alias pip='pip3'

# NVM (node-version-manager) config 
export NVM_DIR="/Users/richardtaylor/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# fzf + ag configuration
export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
