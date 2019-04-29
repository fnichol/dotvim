" Only do this when not done yet for this buffer
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

" https://github.com/rust-dev-tools/fmt-rfcs/blob/master/guide/guide.md#indentation-and-line-width
setlocal colorcolumn=100
