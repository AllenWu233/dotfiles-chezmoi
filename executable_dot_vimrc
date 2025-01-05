" ----- Basic ------ "
set nocompatible
set mouse=a
set encoding=utf-8
set t_Co=256
set timeoutlen=300

" ----- Appearance ----- "
syntax on
set number
set relativenumber
set cursorline
set showmode
set showcmd
set textwidth=80
set wrap
set linebreak
set wrapmargin=2
set scrolloff=999
" set sidescrolloff=8
" set laststatus=2
set ruler

" ----- Indention ----- "
filetype indent on
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

" ----- Search ----- "
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase

" ----- Edit ----- "
set nobackup
set noswapfile
set undofile
set noerrorbells
" set visualbell
set history=1000
set autoread

" Show extra tabs or spaces in the end of a line
set listchars=tab:»■,trail:■
set list

" Completion for command
set wildmenu
set wildmode=longest:list,full


" ----- Keybindings ----- "
" Leader Key
let mapleader = " "

" ==== Normal Mode ==== "
nnoremap <leader>n :nohlsearch<CR>
nnoremap <C-s> <ESC>:w<CR>
nnoremap <leader>= gg=G
nnoremap <leader>qq :qa<CR> 
nnoremap <C-a> ggVG"+y
nnoremap <C-x> ggVGc
nnoremap j gj
nnoremap k gk

" ==== Insert Mode ==== "
inoremap <C-s> <ESC>:w<CR>
inoremap jk <ESC>
inoremap kj <ESC>
inoremap {<CR> {<CR>}<ESC>O

" ==== Visual Mode ==== "
