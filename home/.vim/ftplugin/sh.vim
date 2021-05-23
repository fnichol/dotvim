" Only do this when not done yet for this buffer
if exists('b:did_vimrc_ftplugin')
  finish
endif
let b:did_vimrc_ftplugin = 1

setlocal colorcolumn=80

setlocal tabstop=8
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal expandtab
