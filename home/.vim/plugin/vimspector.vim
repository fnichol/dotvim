if exists('g:did_vimrc_vimspector_loaded') || !exists('g:plugs["vimspector"]')
  finish
endif
let g:did_vimrc_vimspector_loaded = 1

let g:vimspector_enable_mappings='HUMAN'
