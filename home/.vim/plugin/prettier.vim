" Exit quickly when:
" - this plugin was already loaded (or disabled)
if exists('g:loaded_prettier')
  finish
endif
let g:loaded_prettier = 1

function! IsPrettierInstalled()
  if !exists('g:prettier_installed')
    let g:prettier_installed = executable('prettier')
  end

  return g:prettier_installed
endfunction
