function! prettier#detect#Detect() abort
  if !exists('g:prettier_installed')
    let g:prettier_installed = executable('prettier')
  end

  return g:prettier_installed
endfunction
