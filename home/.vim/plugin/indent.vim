" vint: -ProhibitMissingScriptEncoding

if exists('g:did_vimrc_indent_loaded')
  finish
endif
let g:did_vimrc_indent_loaded = 1

if exists('g:plugs["indentLine"]')
  " set a nicer indent line character, if possible
  if (&encoding ==# 'utf-8' && &term isnot# 'linux')
    let g:indentLine_char = '┆'
  endif

  if exists('g:plus["nerdtree"]')
    " Exclude `nerdtree` filetypes from indent behavior
    let g:indentLine_fileTypeExclude = ['nerdtree']
  endif
endif
