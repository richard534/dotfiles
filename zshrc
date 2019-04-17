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

# vim-superman config
export PATH="$PATH:$HOME/.vim/bundle/vim-superman/bin"
compdef vman="man"

# prepend dotfiles bin dir to path
export PATH=$HOME/dotfiles/bin:$PATH

# set default pager to less
export PAGER=less
# set less envar (less options are taken from this envar to avoid typing each time)
# -R displays ANSI color escape sequences in "raw" form. (add colour to less)
# -S disables line wrapping. Side-scroll to see long lines.
# -X leaves file contents on the screen when less exits.
# -F makes less quit if the entire output can be displayed on one screen.
export LESS="-RSXF"

# User defined alias's
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias python='python3'
alias pip='pip3'
alias man='vman'
alias emd='/Applications/Emacs.app/Contents/MacOS/Emacs --daemon'
alias em='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient --no-wait'
alias emc='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -c --no-wait'
alias tree='tree -C'

# fzf + ag configuration
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="rg --files --case-sensitive"

# java config
export JAVA_HOME=`/usr/libexec/java_home -v 1.8.0_202, x86_64` # latest java8 build

SECRET_CONF=~/.zshrc_local && test -f $SECRET_CONF && source $SECRET_CONF

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

