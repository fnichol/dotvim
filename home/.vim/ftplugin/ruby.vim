" Only do this when not done yet for this buffer
if exists('b:did_vimrc_ftplugin')
  finish
endif
let b:did_vimrc_ftplugin = 1

setlocal colorcolumn=80

" Replace insert pry breakpoint in insert mode
imap <buffer> !!p require 'pry' ; binding.pry
