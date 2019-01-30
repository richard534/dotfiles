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

" set vim colourscheme
set t_Co=256
colorscheme molokai
let g:rehash256 = 1
set background=dark

" show line-numbers
set number

" don't wrap lines by default
set nowrap

" show the line and column number of the cursor position, separated by a comma.
set ruler

" enable mouse wheel scrolling
set mouse=a

" enable mouse resizing panes
set mouse=n
set ttymouse=xterm2

" bind keys to resize panes
set winheight=30
set winminheight=5
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>

" enable AutoSave on Vim startup
let g:auto_save = 1

" highlight all matches when searching
set hlsearch
" remap enter key to remove search highlight
nnoremap <CR> :nohlsearch<CR><CR>

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
" bind key to open last file opened
nmap <silent> <leader>m :History<CR>

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

" syntastic recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" size of syntastic location window
let g:syntastic_loc_list_height = 3

" bind key to toggle syntastic passive/active mode
nmap <Leader>st :SyntasticToggleMode<CR>

" flake8-vim plugin config
let g:flake8_quickfix_height=3

" vim-terraform plugin config
let g:terraform_fold_sections=1
let g:terraform_remap_spacebar=1

