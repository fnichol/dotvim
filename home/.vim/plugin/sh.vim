if exists('g:did_vimrc_sh_loaded')
  finish
endif
let g:did_vimrc_sh_loaded = 1

" Assume that filtype=sh are posix and therefore will support proper `$(...)`
" syntax highlighting.
"
" See:
" * https://git.io/fjngy
" * https://github.com/tpope/vim-sensible/issues/140
let g:is_posix = 1
