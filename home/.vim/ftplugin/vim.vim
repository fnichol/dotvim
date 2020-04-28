" Only do this when not done yet for this buffer
if exists('b:did_vimrc_ftplugin')
  finish
endif
let b:did_vimrc_ftplugin = 1

setlocal colorcolumn=80

if !vimrc#vint#detect#Detect()
  command! -nargs=0 -bar -buffer InstallVint call vimrc#vint#install#Install()
endif
