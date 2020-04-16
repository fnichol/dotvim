" Only do this when not done yet for this buffer
if exists('b:did_vimrc_ftplugin')
  finish
endif
let b:did_vimrc_ftplugin = 1

" While an agreed upon line length seems out of scope for TypeScript and
" Prettier to an extent, knowing when a line is longer than 100 characters is
" still useful
setlocal colorcolumn=100
