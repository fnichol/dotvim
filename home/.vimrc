set nocompatible                  " don't make vim vi-compatible (better)

set modelines=0                   " prevent possible exploits in modelines

" remap leader key to comma
let mapleader=","

set encoding=utf-8                " sets the character encoding used inside Vim

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
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

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

" map leader d to NERDTreeToggle (show/hide drawer)
map <leader>d :NERDTreeToggle<cr>

" Strip trailing whitespace on lines
map <leader>ws :%s/ *$//g<cr><c-o><cr>

" Format JSON, thanks to:
" http://blog.realnitro.be/2010/12/20/format-json-in-vim-using-pythons-jsontool-module/
nmap <leader>js :%!python -m json.tool<cr>:%s/ \{4\}/  /<cr>:noh<cr>gg

" Format XML
nmap <leader>xml :%!xmllint --format -<cr>

" Wrap selected lines to 75 char width
nmap <leader>wl :!fmt -w 75<cr>

" Replace insert pry breakpoint in insert mode
imap !!p require 'pry' ; binding.pry

" Preserve selection after indentation
vmap > >gv
vmap < <gv

" Map tab to indent in visual mode
vmap <Tab> >gv
vmap <S-Tab> <gv

set laststatus=2                  " always show status line
                                  " status line info at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

set background=dark               " blue on black background sucks

let s:theme = 'base16-twilight'   " Color scheme to set

function! s:InstallPluginManager()
  let plug_src = "https://github.com/junegunn/vim-plug.git"

  echo "Installing plugin manager..."
  echo ""
  let tmpdir = tempname()
  try
    silent !mkdir -p ~/.vim/autoload
    execute "silent !git clone --depth 1 " . plug_src . " " . tmpdir
    execute "silent !mv " . tmpdir . "/plug.vim ~/.vim/autoload/plug.vim"
  finally
    execute "silent !rm -rf " . tmpdir
  endtry
endfunction

if has("user_commands") && v:version >= 700 && executable('git')
  " Install plugin manager if not installed
  if filereadable(expand('~/.vim/autoload/plug.vim'))
    let s:initial_manager_install = 0
  else
    call s:InstallPluginManager()
    let s:initial_manager_install = 1
  endif

  " Load plugins
  call plug#begin()
  if filereadable(expand('~/.vim/plugins.vim'))
    source ~/.vim/plugins.vim
  endif
  call plug#end()

  " Install plugins if this is the initial installation
  if s:initial_manager_install == 1
    echo "Installing plugins..."
    echo ""
    :PlugInstall --sync | source $MYVIMRC
  endif
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax enable                   " turn on syntax highlighting
  set hlsearch                    " highlights mactches
endif

if has("autocmd")
  filetype plugin indent on       " turn on file type detection
  "
  " Restore cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif

if exists('g:plugs')
  " highlight extra whitespace
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkred guibg=#C75D5D
  " match trailing whitespace (except when typing)
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/

  " set color theme, can be found in colors or in a bundle
  execute 'colorscheme ' . s:theme
elseif v:version >= 600
      \ && filereadable(resolve(expand('~/.vim/colors/vividchalk.vim')))
  " plugin managers not supported here, so colorscheme is found with symlink
  " in colors/ to an installed theme
  colorscheme vividchalk            " set color theme
endif

" The remaining configuration is for loaded plugins, so if the plugin manager
" isn't loaded, exit early
if !exists('g:plugs')
  finish
endif

" close the tree window after opening a file
let g:NERDTreeQuitOnOpen = 1

" enable extended % matching for HTML, LaTeX, and many other languages
runtime macros/matchit.vim

" Ctrl-P ignores
let g:ctrlp_custom_ignore = '\v[\/](tmp|vendor/bundle|\.git)$'

" Ctrl-P sets its local working directory the directory of the current file
let g:ctrlp_working_path_mode = 'a'

" Runs rustfmt on buffer write, if rustfmt exists in $PATH
if executable('rustfmt')
  let g:rustfmt_autosave = 1
endif

"
" = References and Credits =
" - [[http://stevelosh.com/blog/2010/09/coming-home-to-vim/]]
" - [[http://vimcasts.org/episodes/tabs-and-spaces/]]
" - [[http://github.com/rson/dotfiles/blob/master/vim/vimrc]]]
" - [[http://vimcasts.org/episodes/running-vim-within-irb/]]
" - [[http://rsontech.net/articles/2010/10/12/20/vim-plugin-management]]
" - [[http://vim.wikia.com/wiki/Highlight_unwanted_spaces]]

