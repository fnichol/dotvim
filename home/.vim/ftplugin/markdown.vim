" Only do this when not done yet for this buffer
if exists('b:did_vimrc_ftplugin')
  finish
endif
let b:did_vimrc_ftplugin = 1

setlocal colorcolumn=80

if !exists('b:ale_fixers')
  let b:ale_fixers = []
endif

if prettier#detect#Detect()
  let b:ale_fixers += ['prettier']
  let b:ale_javascript_prettier_options = '--parser markdown'
else
  command! -nargs=0 -bar InstallPrettier call prettier#install#Install()
endif

let g:markdown_composer_autostart = 0

if !vim_markdown_composer#detect#Detect()
  command! -nargs=0 -bar InstallVimMarkdownComposer
        \ call vim_markdown_composer#install#Install()
endif
