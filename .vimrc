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
set guifont=Menlo\ Regular:h13
colorscheme gruvbox

set history=500
set autoread " read when file changed from outside
set hidden " a buffer becomes hidden when it is abandoned


" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Indentation settings for using 4 spaces instead of tabs.
"set tabstop=4 "number of visual spaces per tab
set shiftwidth=4
set softtabstop=4 "number of spaces in tab when editing
set expandtab "tab are spaces

set ruler " always show cursor position
set scrolloff=2 " the number of screen lines to keep above and below the cursor
set laststatus=2 " Always display the status line
set number " show line numbers
set showcmd " show command in bottom bar
set cursorline " highlight current line
set relativenumber
set mouse=a " enable use of the mouse for all modes
set cmdheight=2 " command window height

set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when needed
set showmatch " highlight matching [{()}]

set noerrorbells
set novisualbell
set t_vb=

set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" SEARCHING
set ignorecase
set smartcase
set gdefault
set incsearch " search as characters are entered
set hlsearch " highlight matches



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" REMAP KEYS
let mapleader = ","

imap jj <esc>

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy
map Y y$
map 0 ^

" Scroll window up/down
map <C-j> <C-e>
map <C-k> <C-y>

" Page up/down
map <S-j> <C-d>
map <S-k> <C-u>

" Move between tabs
map <leader>j gt
map <leader>k gT 

" Move between windows
map <leader>h <C-W>h
map <leader>l <C-W>l

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
