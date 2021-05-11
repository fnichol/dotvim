" Only do this when not done yet for this buffer
if exists('b:did_vimrc_ftplugin')
  finish
endif
let b:did_vimrc_ftplugin = 1

" Looks like the implied default for Prettier when formatting TypeScript is 80
" characters, src: https://prettier.io/docs/en/options.html#print-width
setlocal colorcolumn=80
