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

" set leader key
let mapleader = '\'

" set vim colourscheme
set t_Co=256
let g:rehash256 = 1
set background=dark
" show line-numbers
set number

" don't wrap lines by default
set nowrap

" org file specific
" wrap lines
" only wrap line at specified 'breakat' char's
autocmd FileType org set wrap | set linebreak

" set avro schema files to json filetype
au BufNewFile,BufRead *.avsc set filetype=json

" show the line and column number of the cursor position, separated by a comma.
set ruler

" enable mouse wheel scrolling
set mouse=a

" enable mouse resizing panes
set mouse=n
if !has('nvim')
	set ttymouse=xterm2
endif

" enable AutoSave on Vim startup
let g:auto_save = 1

" highlight all matches when searching
set hlsearch
" remap key to remove search highlight
nnoremap <Leader><space> :noh<cr>

" set vim updatetime option to lower then default(4000)
" Doing this to improve vim-airgutter plugin
set updatetime=100

" set timeout for mapped key-sequence to complete
set timeoutlen=1000
set ttimeoutlen=0

" on pressing tab, insert spaces
set expandtab
" specifies the number of columns that a tab character should represent
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" set how many columns vim uses when you hit Tab in insert mode
set softtabstop=4

" more natural split opening
set splitbelow
set splitright

" vim tab completion mode for navigating dirs
set wildmode=longest,list,full
set wildmenu

" bind <leader>c to toggle highlighting row/col (double c for col)
:hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:nnoremap <Leader>c :set cursorline!<CR>
:nnoremap <Leader>cc :set cursorcolumn!<CR>

" bind key to buffers command
nmap ; :Buffers<CR>

" bind fzf.vim keys
" search for file names
nmap <Leader>t :Files<CR>
" search for tags
nmap <Leader>r :Tags<CR>
" search for text inside files
nmap <Leader>i :Rg<CR>
" bind key to open last file opened
nmap <silent> <leader>m :History<CR>

" enable folding
set foldmethod=indent " creates folds based upon line indents
set foldlevel=99
" bind key to fold top level folds
nnoremap <F4> :%foldc<CR>
nnoremap <F5> :%foldo<CR>

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" set backspace to delete over line-breaks
set backspace=indent,eol,start

" autocmd BufEnter * if &modifiable | NERDTreeFind | wincmd p | endif
" Open nerdtree automatically
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" quickfix window height is automatically adjusted to fit its contents (maximum 10 lines).
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$")+1, a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" bind key to run current buffer with python
nnoremap <buffer> <F9> :exec '!clear; python' shellescape(@%, 1)<cr>

" set vim to read files that have changed outside of vim
set autoread

" disable swapfiles
set noswapfile

" bind key to insert newline w/o entering insert mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

" disable vim concealing for json
let g:vim_json_syntax_conceal = 0

" json filetype config
au! BufRead,BufNewFile *.json set filetype=json
augroup json_autocmd
	autocmd!
	autocmd FileType json set autoindent
	autocmd FileType json set formatoptions=tcq2l
	autocmd FileType json set textwidth=78 shiftwidth=2
	autocmd FileType json set softtabstop=2 tabstop=8
	autocmd FileType json set expandtab
	autocmd FileType json set foldmethod=syntax
augroup END

" useful keymap for select all
map <C-a> <esc>ggVG<CR>
