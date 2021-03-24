" Only do this when not done yet for this buffer
if exists('b:did_vimrc_ftplugin')
  finish
endif
let b:did_vimrc_ftplugin = 1

setlocal shiftwidth=4
setlocal softtabstop=4

setlocal colorcolumn=80
