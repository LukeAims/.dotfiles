" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible


" ================ Mappings ==============

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all
" the plugins.
let mapleader = "," " map leader to comma

" Now highlights can be hidden by typing ,h in normal mode
map <leader>h :noh<CR>

" ================ General Config  ====================

set backspace=indent,eol,start  " Allow backspace in insert mode
set history=1000                " Store lots of :cmdline history
" set visualbell                " No sounds
set autoread                    " Reload files changed outside vim
set iskeyword+=-              	" Treat dash separated words as a worœd text object
set mouse=a                     " Enable your mouse
set formatoptions-=cro          " Stop newline continution of comments
set clipboard=unnamedplus       " Copy paste between vim and everything else
set autochdir                   " Your working directory will always be the same as your working directory

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" ================ Display Settings ==============

" Use the Solarized Dark theme
set background=dark
colorscheme solarized
let g:solarized_termtrans=1

set t_Co=256                    " Support 256 colors
set timeoutlen=500              " By default timeoutlen is 1000 ms
set encoding=utf-8              " The encoding displayed 
set ruler                       " Add the current line and column
set number                      " Line numbers are good
set cursorline                  " Enable highlighting of the current line
set laststatus=0                " Always display the status line
set gcr=a:blinkon0              " Disable cursor blink
set pumheight=10                " Makes popup menu smaller
set cmdheight=2                 " More space for displaying messages
set showcmd                     " Show incomplete cmds down the bottom
set showmode                    " Show current mode down the bottom

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup                    " This is recommended by coc
set nowritebackup               " This is recommended by coc
set nowb

" ================ Persistent Undo ==================

" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && !isdirectory(expand('~').'/vim/backups')
  silent !mkdir ~/vim/backups > /dev/null 2>&1
  set undodir=~/vim/backups
  set undofile
endif

" ================ Indentation ======================

set tabstop=2                     " Insert 2 spaces for a tab
set shiftwidth=2                  " Change the number of space characters inserted for indentation
set smarttab                      " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                     " Converts tabs to spaces
set smartindent                   " Makes indenting smart
set autoindent                    " Good auto indent
set softtabstop=2

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

filetype plugin on
filetype indent on

set nowrap       " Don't wrap lines
set linebreak    " Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   " fold based on indent
set foldnestmax=3       " deepest fold is 3 levels
set nofoldenable        " dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                        " enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~         " stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set updatetime=300                  " Faster completion

" ================ Scrolling ========================

set scrolloff=8         " Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Tab Settings ========================

set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set showtabline=2                       " Always show tabs 

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Auto Source ===========================

au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vim alternatively you can run :source $MYVIMRC

" You can't stop me
cmap w!! w !sudo tee %
