if exists('g:did_vimrc_json_loaded') || !exists('g:plugs["vim-json"]')
  finish
endif
let g:did_vimrc_json_loaded = 1

" disable JSON syntax concealing
let g:vim_json_syntax_conceal = 0
