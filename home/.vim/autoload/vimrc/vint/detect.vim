function! vimrc#vint#detect#Detect() abort
  let l:var = 'vint_installed'
  let l:buffer = bufnr('')

  if !vimrc#buffer#Exists(l:var)
    " Load language server linter
    silent! runtime! ale_linters/vim/vint.vim

    let l:is_found = executable('vint')

    call vimrc#buffer#Set(l:buffer, l:var, l:is_found)
  end

  return vimrc#buffer#Var(l:buffer, l:var)
endfunction
