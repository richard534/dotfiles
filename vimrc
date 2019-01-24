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

" set vim colourscheme to default
colorscheme default

" show line-numbers
set number

" don't wrap lines by default
set nowrap

" show the line and column number of the cursor position, separated by a comma.
set ruler

" enable AutoSave on Vim startup
let g:auto_save = 1

" highlight all matches when searching
set hlsearch
" remap enter key to remove search highlight
nnoremap <CR> :nohlsearch<CR><CR>

" set vim updatetime option to lower then default(4000)
" Doing this to improve vim-airgutter plugin
set updatetime=100

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
" search for file names
nmap <Leader>t :Files<CR>
" search for tags
nmap <Leader>r :Tags<CR>
" search for text inside files
nmap <Leader>i :Rg<CR>

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

" NERDtree config
" map key to open NERDtree
nmap ,m :NERDTreeToggle<CR>
" map key to find current file in nerdtree
nmap ,n :NERDTreeFind<CR>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" auto delete the buffer of a file you delete with nerdtree
let NERDTreeAutoDeleteBuffer = 1
" auto-close nerdTree when its the only remaining window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" fugitive git bindings
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gb :Gblame<CR>

" map key to toggle tagbar plugin
nmap <F8> :TagbarToggle<CR>

" vim-indent-guides plugin config
let g:indent_guides_enable_on_vim_startup = 1

" bind key to goto previous (last accessed) window
nmap <C-i> <c-w><c-p>

" set vim to read "external-tags" file in .git dir
set tags=./tags;,tags,.git/external-tags;

