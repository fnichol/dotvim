function! yamllint#detect#Detect() abort
  let l:var = 'yamllint_installed'
  let l:buffer = bufnr('')

  if !vimrc#buffer#Exists(l:var)
    let l:is_found = executable('yamllint')

    call vimrc#buffer#Set(l:buffer, l:var, l:is_found)
  end

  return vimrc#buffer#Var(l:buffer, l:var)
endfunction
