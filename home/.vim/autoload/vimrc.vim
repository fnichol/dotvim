function! vimrc#UpdateThenQuit() abort
  PlugUpgrade
  PlugUpdate
  if exists('g:plugs["coc.nvim"]')
    call vimrc#coc#UpdateThenQuit()
  else
    execute 'qall'
  endif
endfunction

function! vimrc#Var(buffer, variable_name) abort
  let l:full_name = vimrc#VarName(a:variable_name)
  let l:vars = getbufvar(str2nr(a:buffer), '', {})

  return get(l:vars, l:full_name, g:[l:full_name])
endfunction

function! vimrc#VarName(variable_name) abort
  return 'vimrc_' . a:variable_name
endfunction

function! vimrc#ErrorMsg(topic, msg) abort
    echohl ErrorMsg
    echo '[' . a:topic . '] ' . a:msg
    echohl None
endfunction
