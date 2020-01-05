" Only do this when not done yet for this buffer
if exists('b:did_vimrc_ftplugin')
  finish
endif
let b:did_vimrc_ftplugin = 1

setlocal colorcolumn=80

if !exists('b:ale_fixers')
  let b:ale_fixers = []
endif

if !exists('b:ale_linters')
  let b:ale_linters = []
endif

if prettier#detect#Detect()
  let b:ale_fixers += ['prettier']
  let b:ale_javascript_prettier_options = '--require-pragma'
else
  command! -nargs=0 -bar InstallPrettier call prettier#install#Install()
endif

if yamllint#detect#Detect()
  let b:ale_linters += ['yamllint']
else
  command! -nargs=0 -bar InstallYamllint call yamllint#install#Install()
endif
