function! vimrc#buffer#Var(buffer, variable_name) abort
  let l:full_name = vimrc#VarName(a:variable_name)

  return getbufvar(str2nr(a:buffer), l:full_name)
endfunction

function! vimrc#buffer#Exists(variable_name) abort
  let l:full_name = vimrc#VarName(a:variable_name)

  return exists('g:' . l:full_name)
endfunction

function! vimrc#buffer#Set(buffer, variable_name, default) abort
  let l:full_name = vimrc#VarName(a:variable_name)
  let l:vars = getbufvar(str2nr(a:buffer), '', {})

  if !has_key(l:vars, l:full_name)
    call setbufvar(str2nr(a:buffer), l:full_name, a:default)
  endif
endfunction

function! vimrc#buffer#Unset(variable_name) abort
  let l:full_name = vimrc#VarName(a:variable_name)

  if has_key(g:, l:full_name)
    unlet g:[l:full_name]
  endif
endfunction
