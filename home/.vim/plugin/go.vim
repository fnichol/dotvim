if exists('g:did_vimrc_go_loaded') || !exists('g:plugs["vim-go"]')
  finish
endif
let g:did_vimrc_go_loaded = 1

" Enable a bit more syntax highlighting for Go code
let g:go_highlight_types = 1
let g:go_highlight_fields = 1

" Disable mapping `gd` for `GoDef` in favor of `coc.nvim`
let g:go_def_mapping_enabled = 0

" Disable mapping `K` for `godoc` in favor of `coc.nvim`
let go_doc_keywordprg_enabled = 0

" Initially disable gopls
let g:go_gopls_enabled = 0
