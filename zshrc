## Oh-my-zsh Config
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git tmux)

source $ZSH/oh-my-zsh.sh

## PATH Config
# Base path
PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin

## Personal dotfiles bin dir
DOTFILES_ROOT="$HOME/dotfiles"
PATH="$DOTFILES_ROOT/bin:$PATH"
PATH="$HOME/.emacs.d/bin:$PATH"

export PATH

## User Config
# Set terminal colour scheme
export TERM='xterm-256color'

# set default pager to less
export PAGER=less

# set less envar (less options are taken from this envar to avoid typing each time)
# -R displays ANSI color escape sequences in "raw" form. (add colour to less)
# -S disables line wrapping. Side-scroll to see long lines.
# -X leaves file contents on the screen when less exits.
# -F makes less quit if the entire output can be displayed on one screen.
export LESS="-RSXF"

## pyenv
# Add pyenv bin to path
PYENV_ROOT="$HOME/.pyenv"
PATH="$PYENV_ROOT/bin:$PATH"
# Check if pyenv cmd available. If so run pyenv init
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  # pyenv virtualenv plugin
  eval "$(pyenv virtualenv-init -)"
fi

## rust
PATH="$HOME/.cargo/bin:$PATH"

export PATH

## direnv
if command -v direnv 1>/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

## java
alias java17="export JAVA_HOME=`/usr/libexec/java_home -v 17`"
alias java11="export JAVA_HOME=`/usr/libexec/java_home -v 11`"

# Default to java version x
java17

# Source secrets file
[ -f ~/.secret ] && source ~/.secret

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
