" turn off vi compatability mode
set nocompatible
" source external vundle plugins file
so ~/.vim/plugins.vim

" turn on filetype detection,plugin and indentation
" (combination of filetype on, filetype plugin on, filetype indent on)
filetype plugin indent on

" allow vim to use system clipboard
set clipboard=unnamed

" enable syntax highlighting
syntax enable

" show line-numbers
set number

" show the line and column number of the cursor position, separated by a comma.
set ruler

" enable AutoSave on Vim startup
let g:auto_save = 1

" highlight all matches when searching
set hlsearch
" remap enter key to remove search highlight
nnoremap <CR> :nohlsearch<CR><CR>

" on pressing tab, insert spaces
set expandtab
" specifies the number of columns that a tab character should represent
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" set how many columns vim uses when you hit Tab in insert mode
set softtabstop=4

" add subtle verticle line to show 80chars
if exists('+colorcolumn')
  set colorcolumn=120
  hi ColorColumn ctermbg=lightgray
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

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
:nnoremap <Leader>cc :set cursorline! cursorcolumn!<CR>


" bind key to buffers command
nmap ; :Buffers<CR>

" bind fzf.vim keys
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>

" enable folding
set foldmethod=indent " creates folds based upon line indents
set foldlevel=99
noremap <space> za

" python folding plugin "simpylfold" config
let g:SimpylFold_docstring_preview=1

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" set backspace to delete over line-breaks
set backspace=indent,eol,start

" map key to open NERDtree
map <C-n> :NERDTreeToggle<CR>

