" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'vim-test/vim-test'

set nocompatible                    " don't worry about being vi compatible
set nocp
call pathogen#infect('bundle/{}')
filetype plugin on                  " we need this for some plugins
set modelines=0                     " fix security vulnerability
set tabstop=4                       " tab characters count for 4 columns
set shiftwidth=4                    " indent operations move text 4 columns
set softtabstop=4                   " how many cols to use when hitting tab
set expandtab                       " insert spaces when hitting tab
set encoding=utf-8
set scrolloff=5                     " we get 5 lines of context for searches
set autoindent                      " newlines start at same indent as prev
set showmode                        " display current mode bottom left
set showcmd                         " show command at bottom of screen
set wildmenu
set wildmode=list:longest           " make command completion sane
set ttyfast                         " make screen redrawing faster
set ruler                           " show ROW, COL of cursor bottom right
set backspace=indent,eol,start      " make backspacing work
set laststatus=2                    " always show the status line
set undofile                        " undos persist across sessions
set wrap                            " softwrap lines wider than the window
set formatoptions+=q                " allow formatting of comments with gq
set formatoptions+=n                " recognise numbered lists when formatting
set formatoptions+=1                " don't break lines after 1-letter words
"set textwidth=72                    " Lines break at 72 chars
set ignorecase                      " iff we search on an all-lowercase ...
set smartcase                       " ... string we are case-insensitive
set gdefault                        " apply substitutions globally by default
set incsearch                       " highlight
set showmatch                       "          search results
set hlsearch                        "                        as we type
set number
let mapleader = ','                 " remap leader key to ,
" Reload filetype stuff after vim knows where to look for golang stuff
filetype off
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim
filetype plugin indent on
" Colour and highlighting
" -----------------------
set background=dark
syntax on
colorscheme molokai
" Plugin customisation
" --------------------
let g:ale_fixers = {
  \ 'javascript': ['eslint'],
\   'python': ['isort'],
  \ }
let g:ale_linters = {
\   'python': ['flake8'],
\   'javascript': ['eslint'],
\   'html': ['tidy'],
\}
let g:ale_fix_on_save = 1
nmap <leader>d <Plug>(ale_fix)
" Pytest
nmap <silent><Leader>f <Esc>:Pytest file<CR>
nmap <silent><Leader>c <Esc>:Pytest class<CR>
nmap <silent><Leader>m <Esc>:Pytest method<CR>
" Put tmp files in a central location:
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
"clear out searches using ,<space>
nnoremap <leader><space> :noh<cr>
"tab key matches to bracket pairs in normal and visual modes
nnoremap <tab> %
vnoremap <tab> %
" disable the cursor keys in normal and insert modes
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
"j and k operate across visual, rather than logical lines
nnoremap j gj
nnoremap k gk
" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
" ,W strips all trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" ,q re-hardwraps paragraphs of text
nnoremap <leader>q gqap
" ,v selects the text that was just pasted into a buffer
nnoremap <leader>v V`]
" equalise split size on resize
autocmd VimResized * wincmd =
set equalalways
map <F5> :w<CR>:exe ":!python " . getreg("%") . "" <CR>
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype html setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
let g:netrw_banner = 0
let g:netrw_liststyle = 3
" Autocomplete on tab
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

autocmd BufWritePre *.py execute ':Black'

" Test-vimm bindings
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
