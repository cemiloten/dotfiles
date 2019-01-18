set nocompatible
filetype indent plugin on
syntax on

set langmenu=en_US.UTF-8
let $LANG = 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
source $VIMRUNTIME/vimrc_example.vim

set guifont=Source\ Code\ Pro\ Semibold:h10
colorscheme gruvbox

if has("gui_running")
    set lines=60 columns=160
endif

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Indentation settings for using 4 spaces instead of tabs.
"set tabstop=4 "number of visual spaces per tab
set shiftwidth=4
set softtabstop=4 "number of spaces in tab when editing
set expandtab "tab are spaces

set ruler " display the cursor position on the last line of the screen or in the status line of a window
set laststatus=2 " Always display the status line
set number " show line numbers
set showcmd " show command in bottom bar
set cursorline " highlight current line
set mouse=a " enable use of the mouse for all modes
set cmdheight=2 " command window height
"set visualbell " flash the screen instead of beeping on errors

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**
set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when needed
set showmatch " highlight matching [{()}]

set incsearch " search as characters are entered
set hlsearch " highlight matches

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

"search for occurences of visual selection
:vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

