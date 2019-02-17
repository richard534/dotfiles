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

" enable reading manpages in vim
runtime! ftplugin/man.vim
" disable indentlines when man page open
au FileType man :IndentLinesToggle

" set text encoding to utf-8
set encoding=utf-8

" set vim colourscheme
set t_Co=256
colorscheme molokai
let g:rehash256 = 1
set background=dark

" set leader key to space
let mapleader=" "

" show line-numbers
set number

" don't wrap lines by default
set nowrap

" org file specific
" wrap lines
" only wrap line at specified 'breakat' char's
autocmd FileType org set wrap | set linebreak

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
nnoremap <silent> \ :let @/=""<return>

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
" sync nerdtree with currently open file
nnoremap <leader>w :NERDTreeFind<cr><c-w><c-p>
" nerdtree "autoscroll from source"
function! AutoNTFinder()
    if g:NERDTree.IsOpen() && &buftype == ''
        let l:winnr = winnr()
        let l:altwinnr = winnr('#')

        :NERDTreeFind

        execute l:altwinnr . 'wincmd w'
        execute l:winnr . 'wincmd w'
    endif
endfunction

autocmd BufEnter * silent! call AutoNTFinder()

" autocmd BufEnter * if &modifiable | NERDTreeFind | wincmd p | endif
" Open nerdtree automatically
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" fugitive git bindings
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gd :Gdiff<CR>

" map key to toggle tagbar plugin
nnoremap <silent> <Leader>b :TagbarToggle<CR>
" set tagbar to sort functions/method by order in file
let g:tagbar_sort = 0
" do not show help tip on tagbar
let g:tagbar_compact = 1

" set vim to read "external-tags" file in .git dir
set tags=./tags;,tags,.git/external-tags;

" config vim-indent-guides plugin
set ts=4 sw=4 noet

" flake8-vim plugin config
let g:flake8_quickfix_height=3

" vim-terraform plugin config
let g:terraform_fold_sections=1
let g:terraform_remap_spacebar=1

" quickfix window height is automatically adjusted to fit its contents (maximum 10 lines).
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$")+1, a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" youcompleteme plugin config
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <leader>n :YcmCompleter GoToReferences<CR>
nnoremap <leader>d :YcmCompleter GetDoc<CR>
nnoremap <leader>a :YcmCompleter GetType<CR>1gs

" add virtualenv support to youcompleteme
let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = '~/global_extra_conf.py'

" bind keys to vanilla vim session management commands
map <F2> :mksession! ~/vim_session <cr> " Quick write session with F2
map <F3> :source ~/vim_session <cr>     " And load session with F3

" set vim to read files that have changed outside of vim
set autoread

" disable swapfiles
set noswapfile

" bind key to insert newline w/o entering insert mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

" disable vim concealing for json
let g:vim_json_syntax_conceal = 0

