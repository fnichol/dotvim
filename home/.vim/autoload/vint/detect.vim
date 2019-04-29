function! vint#detect#Detect() abort
  if !exists('g:vint_installed')
    let g:vint_installed = executable('vint')
  end

  return g:vint_installed
endfunction
