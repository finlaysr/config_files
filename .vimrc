" SETTINGS ---------------------------------------------------------------- {{{
" Add numbers to each line on the left-hand side.
set number
set relativenumber

" disable compatibility with vi which can cause unexpected issues.
set nocompatible
"Enable type file detection. Vim will be able to try to detect the type offile in use.
filetype on
" Enable plugins and load plugin for the detected file type.
filetype plugin on
" Load an indent file for the detected file type.
filetype indent on
" Turn syntax highlighting on.
syntax on
" Highlight cursor line underneath the cursor horizontally
set cursorline

" Set shift width to 4 spaces.
set shiftwidth=4
" Set tab width to 4 columns.
set tabstop=4
" Use space characters instead of tabs.
set expandtab
" Do not save backup files.
set nobackup

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10
" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap
" While searching though a file incrementally highlight matching characters as you type.
set incsearch
" Ignore capital letters during search.
set ignorecase
" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd
" Show the mode you are on the last line.
set showmode
" Show matching words during a search.
set showmatch
" Use highlighting when doing a search.
set hlsearch
" Set the commands to save in history default number is 20.
set history=1000

" Enable mouse mode
set mouse=a

" Enable 24-bit colour if available
if (has("termguicolors"))
  set termguicolors
endif

" Use a line cursor within insert mode and a block cursor everywhere else.
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"  
  
  
" }}}

" PLUGINS ---------------------------------------------------------------- {{{

call plug#begin()

" List your plugins here
Plug 'flazz/vim-colorschemes' " Install a bunch of color schemes
Plug 'sheerun/vim-polyglot' " lanjuage packs
Plug 'preservim/nerdtree'   " File tree, open with :NERDTree
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] } " show shortcuts
Plug 'vim-airline/vim-airline' " statusline at bottom
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy file finding
Plug 'tpope/vim-fugitive' " Git operations :Git

call plug#end()

" :PlugUpdate, :PlugClean

set background=dark    " Setting dark mode
colorscheme molokai

" }}}


