" load pathogen managed plugins
call pathogen#runtime_append_all_bundles()

set nocompatible		              " don't make vim vi-compatible (better)

syntax enable			                " turn on syntax highlighting
filetype plugin indent on	        " turn on file type detection

set showcmd			                  " display incomplete commands
set showmode			                " display your current mode

set backspace=indent,eol,start	  " intuitive backspacing

set hidden			                  " handle multiple buffers better

set wildmenu			                " enhanced command line completion
set wildmode=list:longest	        " complete files like a shell

set ignorecase			              " case insensitive matching
set smartcase			                " turns case-sensitive if expression contains
				                          " a capital letter

set number			                  " display line numbers
set ruler			                    " show cursor position

set incsearch			                " highlight matching as you type
set hlsearch			                " highlights mactches

set wrap			                    " turn on line wrapping
set scrolloff=3			              " show 3 lines of context around the cursor

set title			                    " set the terminal title

set visualbell			              " no beeping

set tabstop=2			                " number of spaces that a <Tab> in the file 
                                  " counts for
set shiftwidth=2		              " number of spaces to use for each step of 
                                  " (auto)indent
set expandtab			                " use spaces instead of tabs

set laststatus=2		              " always show status line
				                          " status line info at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

colorscheme vividchalk            " set color theme
