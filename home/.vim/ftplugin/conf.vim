" Only do this when not done yet for this buffer
if exists('b:did_vimrc_ftplugin')
  finish
endif
let b:did_vimrc_ftplugin = 1

setlocal tabstop=8
setlocal softtabstop=8
setlocal shiftwidth=8
setlocal noexpandtab
