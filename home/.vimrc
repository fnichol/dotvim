" removes all vimrc autocommands to avoid autocmds appearing twice when vimrc
" is sourced twice
augroup vimrc
  autocmd!
augroup END

" vint: -ProhibitSetNoCompatible
set nocompatible                  " don't make vim vi-compatible (better)

set modelines=0                   " prevent possible exploits in modelines

" remap leader key to comma
let mapleader=','

" vint: -ProhibitEncodingOptionAfterScriptEncoding
set encoding=utf-8                " sets the character encoding used inside Vim
scriptencoding utf-8

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
set scrolloff=0                   " show 3 lines of context around the cursor

set title                         " set the terminal title

set cmdheight=2                   " give more space for displaying messages

set visualbell                    " no beeping

set nobackup                       " don't make backup before overwriting file
set nowritebackup                 " same again

set directory=$HOME/.vim/tmp//,.  " keep swap files in one location"

set tabstop=8                     " number of spaces that a <Tab> in the file
                                  " counts for
set shiftwidth=2                  " number of spaces to use for each step of
                                  " (auto)indent
set softtabstop=2                 " number of spaces that using <Tab> counts for
set expandtab                     " use spaces instead of tabs

set list                          " display unprintable characters

set updatetime=300                " longer update times leads to noticeable
                                  " delays and poor user experience
                                  " (used by coc.nvim)
set shortmess+=c                  " don't pass messages to ins-completion-menu
                                  " (used by coc.nvim)

" setting display chars for tab and eol
if (&encoding ==# 'utf-8' && &term isnot# 'linux')
  set listchars=tab:┆\ ,trail:-,extends:>,precedes:<,nbsp:+
else
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

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

" Strip trailing whitespace on lines
map <leader>ws :%s/ *$//g<cr><c-o><cr>

" Wrap selected lines to 75 char width
nmap <leader>wl :!fmt -w 75<cr>

" Preserve selection after indentation
vmap > >gv
vmap < <gv

" Map tab to indent in visual mode
vmap <Tab> >gv
vmap <S-Tab> <gv

set laststatus=2                  " always show status line

set background=dark               " blue on black background sucks

let s:theme = 'base16-twilight'   " Color scheme to set

" Set terminal type for which mouse codes are recognized when running under
" screen or tmux, or using the Alacritty terminal emulator
if &term =~? '^screen' || &term =~? '^tmux' || &term ==? 'alacritty'
  if has('mouse_sgr')
    " Prefer the newer `sgr` mouse handling, if supported by vim
    set ttymouse=sgr
  else
    " Otherwise fall back to `xterm2`
    set ttymouse=xterm2
  endif
endif

" Enable mouse support
set mouse=a

call vimrc#plug#Load('~/.vim/plugins.vim')

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has('gui_running')
  syntax enable                   " turn on syntax highlighting
  set hlsearch                    " highlights mactches
endif

if has('autocmd')
  filetype plugin indent on       " turn on file type detection
  "
  " Restore cursor position
  autocmd vimrc BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif

if exists('g:plugs')
  " highlight extra whitespace
  autocmd vimrc ColorScheme * highlight ExtraWhitespace
        \ ctermbg=darkred guibg=#C75D5D
  " match trailing whitespace (except when typing)
  autocmd vimrc BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd vimrc InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd vimrc InsertLeave * match ExtraWhitespace /\s\+$/

  " If base16-shell is in use, then read colors from '~/.vimrc_background`
  " which has corrected colors for a 256-color theme variant
  if exists('$BASE16_THEME')
        \ && filereadable(expand('~/.base16_theme'))
        \ && filereadable(expand('~/.vimrc_background'))
    let base16colorspace=256
    source ~/.vimrc_background
  else
    if has('mac') && match(&term, '-256color$') != -1
      " Set the `t_8f` and `t_8b` options if running in tmux or screen
      if match(&term, '^screen-') != -1
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      endif
      " Set termguicolors if running on macOS in a 256 color term
      set termguicolors
    elseif !has('mac')
      " Set base16colorspace if not running on macOS
      let base16colorspace=256
    endif

    " Set color theme, can be found in colors or in a bundle
    execute 'colorscheme ' . s:theme
  endif
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

" Insert the current date (i.e. `YYYY-MM-DD`) in insert and command modes
noremap! <leader>d <C-R>=strftime('%F')<CR>

" Clear the background color in Termite or a 256 color term to get transparent
" background
if &term ==? 'xterm-termite' || match(&term, '-256color$') != -1
  highlight Normal ctermbg=NONE
endif

"
" = References and Credits =
" - [[http://stevelosh.com/blog/2010/09/coming-home-to-vim/]]
" - [[http://vimcasts.org/episodes/tabs-and-spaces/]]
" - [[http://github.com/rson/dotfiles/blob/master/vim/vimrc]]]
" - [[http://vimcasts.org/episodes/running-vim-within-irb/]]
" - [[http://rsontech.net/articles/2010/10/12/20/vim-plugin-management]]
" - [[http://vim.wikia.com/wiki/Highlight_unwanted_spaces]]
" - [[https://github.com/booyaa/rustlangserver.github.io]]
" - [[https://github.com/leafgarland/vimfiles/blob/master/.vimrc]]
" - [[http://seenaburns.com/vim-setup-for-rust/]]
" - [[https://learnvimscriptthehardway.stevelosh.com/chapters/17.html]]
" - [[https://shapeshed.com/vim-statuslines/]]
