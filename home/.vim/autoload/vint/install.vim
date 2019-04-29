function! vint#install#Install() abort
  if !executable('pip')
    echohl ErrorMsg
    echo '[vint] ' .
          \ 'pip not found which is required. Please install Python and retry.'
    echohl None
    return 0
  endif

  execute 'silent !pip install vim-vint'

  if v:shell_error == 0
    redraw!
    delcommand InstallVint
    if exists('g:vint_installed')
      " Clear any state for next detect
      unlet g:vint_installed
    endif
    echom '[vint] Installation complete.'
    return 1
  else
    echohl ErrorMsg
    echo '[vint] Failed to install'
    echohl None
    return 0
  endif
endfunction
