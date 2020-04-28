" Only do this when not done yet for this buffer
if exists('b:did_vimrc_ftplugin')
  finish
endif
let b:did_vimrc_ftplugin = 1

setlocal colorcolumn=80

if !vimrc#yamllint#detect#Detect()
  command! -nargs=0 -bar -buffer InstallYamllint
        \ call vimrc#yamllint#install#Install()
endif
