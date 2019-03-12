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
Plugin 'tomasr/molokai'
Plugin 'yggdroot/indentline'
Plugin 'w0rp/ale'
Plugin 'suan/vim-instant-markdown'
Plugin 'hashivim/vim-terraform'
Plugin 'jez/vim-superman'
Plugin 'tpope/vim-unimpaired'
Plugin 'valloric/youcompleteme'
Plugin 'tpope/vim-commentary'
Plugin 'elzr/vim-json'
Plugin 'prettier/vim-prettier'
Plugin 'jparise/vim-graphql'
call vundle#end()

