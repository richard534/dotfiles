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

# Disable warning msg on macos
export BASH_SILENCE_DEPRECATION_WARNING=1

# Set '\w' char. in prompt variables to trim current dir path at x depth
export PROMPT_DIRTRIM=3

export EDITOR="emacsclient"

# PATH ########################################################################

# Base path
PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin

## Personal dotfiles bin dir
DOTFILES_ROOT="$HOME/dotfiles"
PATH="$DOTFILES_ROOT/bin:$PATH"

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

## Visual Studio Code
VS_CODE="/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
PATH="$VS_CODE:$PATH"

## emacs
PATH="$HOME/.emacs.d/bin:$PATH"

export PATH

# Bash autocomplete settings ##################################################

# Bind tab to cycle options
bind '"\t":menu-complete'
bind '"\e[Z":menu-complete-backward'

# Ignore case when autocompleting
bind 'set completion-ignore-case on'

# Display a list of the matching files
bind 'set show-all-if-ambiguous on'

# Perform partial completion on the first Tab press,
# only start cycling full results on the second Tab press
bind 'set menu-complete-display-prefix on'

# Enable git bash completion (requires brew bash_completion pkg)
[ -f /usr/local/etc/bash_completion ] && source /usr/local/etc/bash_completion

# Prompt variables ############################################################

export PS1="\[\033[38;5;11m\]\u\[$(tput sgr0)\]@\h:\[$(tput sgr0)\]\[\033[38;5;6m\][\w]\[$(tput sgr0)\]:\[$(tput sgr0)\]\[\e[91m\]\$(parse_git_branch)\[\e[00m\]$ "

# Bash History ################################################################

# Avoid duplicates
HISTCONTROL=ignoredups:erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# Read && Execute additional bash files #######################################

# Read and execute ~/.bash_aliases file
if [ -e $HOME/.bash_aliases ]; then
    source $HOME/.bash_aliases
fi

# Read and execute ~/.bash_functions file
if [ -e $HOME/.bash_functions ]; then
    source $HOME/.bash_functions
fi

# Install fzf keybinds
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# Conf. fzf to use fd instead of find (default)
export FZF_DEFAULT_COMMAND='fd .'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d ."
. "$HOME/.cargo/env"
