                                  " set font and size
set guifont=JetBrains\ Mono\ 10,Inconsolata\ 12
set antialias                     " smooth fonts (for MacVim)
set encoding=utf-8                " use UTF-8 everywhere

set guioptions-=T                 " hide toolbar (extreme vim)

set guioptions-=L                 " don't show left-hand scrollbar in a vert split
set guioptions-=r                 " don't show right-hand scrollbar ever

set background=dark               " background color

set lines=40 columns=85           " window dimensions

if has("gui_macvim")
  set transparency=15
endif
