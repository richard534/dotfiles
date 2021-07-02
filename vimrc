" turn off vi compatability mode
set nocompatible

" turn on filetype detection,plugin and indentation
" (combination of filetype on, filetype plugin on, filetype indent on)
filetype plugin indent on

" Integrate with system clipboard
""sets the default copy register to be both * and +
set clipboard=unnamedplus,unnamed

" All searches will be case insensitive
set ignorecase
" search will be case sensitive if it contains an uppercase letter (and vice-versa)
set smartcase

" enable syntax highlighting
syntax enable

" set text encoding to utf-8
set encoding=utf-8

"" Leader Key binds
" bind key to insert newline w/o entering insert mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>
" remap key to remove search highlight
nnoremap <Leader><space> :noh<cr>

" don't wrap lines by default
set nowrap

" highlight all matches when searching
set hlsearch

" set timeout for mapped key-sequence to complete
set timeoutlen=1000
set ttimeoutlen=0

" more natural split opening
set splitbelow
set splitright

" vim tab completion mode for navigating dirs
set wildmode=longest,list,full
set wildmenu

" enable folding
set foldmethod=indent " creates folds based upon line indents
set foldlevel=99

" set backspace to delete over line-breaks
set backspace=indent,eol,start

" disable swapfiles
set noswapfile

" useful keymap for select all
map <C-a> <esc>ggVG<CR>