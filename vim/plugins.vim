set rtp+=~/.vim/bundle/Vundle.vim
" Add homebrew fzf to the vim run-time-path:
set rtp+=/usr/local/opt/fzf

" required by vundle
filetype off

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin '907th/vim-auto-save'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'junegunn/fzf.vim'
Plugin 'tmhedberg/simpylfold'
call vundle#end()

