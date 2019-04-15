set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

filetype off

if has('win32') || has('win64')
    let g:python3_host_prog = 'C:\\Users\\Cemil Oten\\AppData\\Local\\Programs\\Python\\Python37-32\\python.exe'
elseif has('mac')
    let g:python3_host_prog = '/usr/local/bin/python3'
else
    let g:python3_host_prog = '/usr/bin/python3.6'
endif


call plug#begin('~/.vim/plugged')
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

    if has('win32') || has('win64')
        Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next', 'do': 'powershell -executionpolicy bypass -File install.ps1', }
    else
        Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next', 'do': 'bash install.sh', }
    endif

    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'justinmk/vim-sneak'
    Plug 'vim-airline/vim-airline'

    " Color schemes
    Plug 'junegunn/seoul256.vim'
    Plug 'ayu-theme/ayu-vim'
    Plug 'morhetz/gruvbox'
    Plug 'arcticicestudio/nord-vim'
    Plug 'altercation/vim-colors-solarized'
call plug#end()

let g:deoplete#enable_at_startup = 1


set hidden
if has('win32') || has('win64')
    let g:LanguageClient_serverCommands = {
        \ 'cpp': ['C:\Program Files (x86)\LLVM\bin\clangd.exe'],
        \ }
elseif has('mac')
    let g:LanguageClient_serverCommands = {
        \ 'cpp': ['/usr/local/Cellar/llvm/8.0.0/bin/clangd'],
        \ }
else
    let g:LanguageClient_serverCommands = {
        \ 'cpp': ['clangd'],
        \ }
endif


" Colors
syntax on
if (has('termguicolors'))
    set termguicolors
endif
set background=dark
colorscheme gruvbox


set history=1024
set autoread
set splitright
set splitbelow
set backspace=indent,eol,start
set shiftwidth=4
set softtabstop=4
set expandtab
set ruler
set scrolloff=2
set laststatus=2
set number
set showcmd
set cursorline
set mouse=a
set cmdheight=2
set showmode
set matchtime=2
set report=0
set wildmenu
set lazyredraw
set showmatch


""""""" SEARCHING
set ignorecase
set smartcase
set incsearch " search as characters are entered
set hlsearch " highlight matches
set gdefault


""""""" REMAP KEYS

noremap \ ,
let mapleader = ","
imap ,, <esc>
imap jk <esc>

map Y y$
noremap 0 ^
noremap ^ 0
noremap j gj
noremap k gk
noremap gj J
noremap <leader>o o<CR>
noremap <leader>O O<esc>O

" move to the right in insert mode
inoremap <S-space> <Right>

noremap <S-j> gT
noremap <S-k> gt
noremap <C-j> 5<C-e>
noremap <C-k> 5<C-y>

noremap <leader>y "+y
noremap <leader>p "+p


" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>


" save file
nnoremap zz :w<CR>
noremap <leader>w :confirm quit<CR>

" exit terminal (neovim)
tnoremap <esc> <C-\><C-n>

nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

if has('win32') || has('win64')
    map <leader>fd :py3file C:\Program Files (x86)\LLVM\share\clang\clang-format.py<CR>
elseif has('mac')
    map <leader>fd :py3file /usr/local/Cellar/llvm/8.0.0/share/clang/clang-format.py<CR>
else
    map <leader>fd :py3file /home/cemil/llvm/share/clang/clang-format.py<CR>
endif

" Load config (vimrc) file
:command! Init :exe 'edit '.stdpath('config').'/init.vim'

" fuzzy finder
noremap <leader>. :FZF<CR>

" Split terminal
:command! T    :vsplit | terminal
:command! Te   :vsplit | terminal
:command! Ter  :vsplit | terminal
:command! Term :vsplit | terminal

" remove ugly complete menu in nvim-qt
if has('win32') || has('win64')
    GuiPopupmenu 0
endif

set wildignore=*.o,*~,*.d,*.obj,*.class,*.pyc,*.bak,*.swp,*.orig
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif
