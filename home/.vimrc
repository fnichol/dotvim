" load pathogen managed plugins
try
  " this throws an E107 error if not on vim 7,
  " even with a version trap around it.  just
  " catch it and load vim 6 plugins later.
  filetype off
  call pathogen#runtime_append_all_bundles()
catch /^Vim\%((\a\+)\)\=:E107/
  " pass
endtry

set nocompatible                  " don't make vim vi-compatible (better)

set modelines=0                   " prevent possible exploits in modelines

if has("autocmd")
  filetype plugin indent on       " turn on file type detection
  "
  " Restore cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif

" remap leader key too comma
let mapleader=","

set showcmd                       " display incomplete commands
set showmode                      " display your current mode

set backspace=indent,eol,start    " intuitive backspacing

set hidden                        " handle multiple buffers better

set wildmenu                      " enhanced command line completion
set wildmode=list:longest         " complete files like a shell

" use normal (perl-style) regext formatting
nnoremap / /\v
vnoremap / /\v
set ignorecase                    " case insensitive matching
set smartcase                     " turns case-sensitive if expression contains
                                  " a capital letter
set gdefault                      " :substitute flag 'g' is default on
set incsearch                     " highlight matching as you type

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on                       " turn on syntax highlighting
  set hlsearch                    " highlights mactches
endif

" clear out a search, remove highlighting
nnoremap <leader><space> :noh<cr>

set number                        " display line numbers
set ruler                         " show cursor position

set wrap                          " turn on line wrapping
set scrolloff=3                   " show 3 lines of context around the cursor

set title                         " set the terminal title

set visualbell                    " no beeping

set nobackup                       " don't make backup before overwriting file
set nowritebackup                 " same again

set directory=$HOME/.vim/tmp//,.  " keep swap files in one location"

set tabstop=2                     " number of spaces that a <Tab> in the file 
                                  " counts for
set shiftwidth=2                  " number of spaces to use for each step of 
                                  " (auto)indent
set softtabstop=2                 " number of spaces that using <Tab> counts for
set expandtab                     " use spaces instead of tabs

set list                          " display unprintable characters

" setting display chars for tab and eol
set listchars=tab:▸\ ,eol:¬

" ctrl+h: nav to left window
nnoremap <C-h> <C-w>h
" ctrl+j: nav to the window below
nnoremap <C-j> <C-w>j
" ctrl+k: nav to the window above
nnoremap <C-k> <C-w>k
" ctrl+l: nav to the right window
nnoremap <C-l> <C-w>l
" opens new vert split and switch over to it
map <leader>w <C-w>v<C-w>l

" map F2 to NERDTreeToggle (show/hide drawer)
map <F2> :NERDTreeToggle<cr>

" forgot to use sudo for editing?
cmap w!! w !sudo tee % >/dev/null

" Strip trailing whitespace on lines
map <leader>ws :%s/ *$//g<cr><c-o><cr>

" Format JSON, thanks to:
" http://blog.realnitro.be/2010/12/20/format-json-in-vim-using-pythons-jsontool-module/
map <leader>js :%!python -m json.tool<cr>

" Preserve selection after indentation
vmap > >gv
vmap < <gv

" Map tab to indent in visual mode
vmap <Tab> >gv
vmap <S-Tab> <gv

set encoding=utf-8                " sets the character encoding used inside Vim

set laststatus=2                  " always show status line
                                  " status line info at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

set background=dark               " blue on black background sucks

if v:version >= 600
  " pathogen is not supported here, so colorscheme is found with symlink
  " in colors/ to bundle/vim-vivdchalk/colors/
  colorscheme vividchalk            " set color theme
endif

if v:version >= 700
  " can be found in colors or in a pathogen bundle
  colorscheme vividchalk            " set color theme
endif

" enable extended % matching for HTML, LaTeX, and many other languages
runtime macros/matchit.vim

"
" = References and Credits =
" - [[http://stevelosh.com/blog/2010/09/coming-home-to-vim/]]
" - [[http://vimcasts.org/episodes/tabs-and-spaces/]]
" - [[http://github.com/rson/dotfiles/blob/master/vim/vimrc]]]
" - [[http://vimcasts.org/episodes/running-vim-within-irb/]]
" - [[http://rsontech.net/articles/2010/10/12/20/vim-plugin-management]]

