function! yamllint#detect#Detect() abort
  if !exists('g:yamllint_installed')
    let g:yamllint_installed = executable('yamllint')
  end

  return g:yamllint_installed
endfunction
