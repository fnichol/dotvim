" Only do this when not done yet for this buffer
if exists('b:did_vimrc_ftplugin')
  finish
endif
let b:did_vimrc_ftplugin = 1

setlocal colorcolumn=80

if !vint#detect#Detect()
  command! -nargs=0 -bar InstallVint call vint#install#Install()
endif
