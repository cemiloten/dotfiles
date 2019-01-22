set nocompatible
filetype off

set rtp^=~/.vim/bundle/ctrlp.vim
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-abolish'
Plugin 'junegunn/seoul256.vim'
Plugin 'morhetz/gruvbox'
call vundle#end()
filetype indent plugin on

" YouCompleteMe settings
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_complete_in_comments = 1
let g:ycm_confirm_extra_conf = 0
" let g:ycm_collect_identifiers_from_tags_files = 1 " turn on tag completion
set completeopt-=preview
let g:ycm_cache_omnifunc = 0
let g:ycm_seed_identifiers_with_syntax = 1

syntax on
set encoding=utf-8
set guifont=Monaco:h13
colorscheme gruvbox

set history=1024
set autoread " read when file changed from outside
set hidden " a buffer becomes hidden when it is abandoned
set splitright
set splitbelow
set backspace=indent,eol,start
set shiftwidth=4
set softtabstop=4 "number of spaces in tab when editing
set expandtab "tab are spaces
set ruler " always show cursor position
set scrolloff=3 " the number of screen lines to keep above and below the cursor
set laststatus=2 " Always display the status line
set number " show line numbers
set showcmd " show command in bottom bar
set cursorline " highlight current line
set relativenumber
set mouse=a " enable use of the mouse for all modes
set cmdheight=2 " command window height
set showmode " show which mode we are in
set matchtime=2 " when writing braces, only briefly flash the opening one (200ms)
set report=0 " always report how many occurences were changed by change/replace etc
set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when needed
set showmatch " highlight matching [{()}]

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

set wildignore=*.o,*~,*.d,*.obj,*.class,*.pyc,*.bak,*.swp,*.orig
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" SEARCHING
set ignorecase
set smartcase
set incsearch " search as characters are entered
set hlsearch " highlight matches
set gdefault



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" REMAP KEYS
let mapleader = ","

imap ,, <esc>
" Map Y to yank until EOL, rather than act as yy
map Y y$
map 0 ^
nnoremap X "_dd
" when )} is added automatically quick move without exiting insert mode
inoremap <S-space> <Right>

noremap <S-j> <C-d>
noremap <S-k> <C-u>
noremap <C-j> 3<C-e>
noremap <C-k> 3<C-y>
noremap <leader>j gt
noremap <leader>k gT
noremap <leader>h <C-w>h
noremap <leader>l <C-w>l

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" yank to clipboard (like ctrl+c)
noremap <leader>y "+y

" paste from clipboard (like ctrl+v)
noremap <leader>p "+p

" delete without storing in any buffers
nnoremap <leader>d "_d<CR>

" repeat last command
map <leader>. :@:<CR>

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" open vimrc 
:command Vimrc :vsplit $MYVIMRC

" source vimrc
:command Svimrc :source $MYVIMRC

inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
