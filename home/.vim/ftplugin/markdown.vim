" Only do this when not done yet for this buffer
if exists('b:did_vimrc_ftplugin')
  finish
endif
let b:did_vimrc_ftplugin = 1

setlocal colorcolumn=80

let g:markdown_composer_autostart = 0

if !vimrc#vim_markdown_composer#detect#Detect()
  command! -nargs=0 -bar -buffer InstallVimMarkdownComposer
        \ call vimrc#vim_markdown_composer#install#Install()
endif
