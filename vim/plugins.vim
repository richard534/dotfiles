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
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'majutsushi/tagbar'
Plugin 'google/vim-searchindex'
Plugin 'davidhalter/jedi-vim'
Plugin 'tomasr/molokai'
Plugin 'yggdroot/indentline'
Plugin 'vim-syntastic/syntastic'
call vundle#end()

