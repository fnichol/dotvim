" Only do this when not done yet for this buffer
if exists('b:did_vimrc_ftplugin')
  finish
endif
let b:did_vimrc_ftplugin = 1

setlocal colorcolumn=80

if !exists('b:ale_linters')
  let b:ale_linters = []
endif

if vint#detect#Detect()
  let b:ale_linters += ['vint']
else
  command! -nargs=0 -bar InstallVint call vint#install#Install()
endif
