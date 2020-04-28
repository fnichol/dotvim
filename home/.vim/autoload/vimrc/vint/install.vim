function! vimrc#vint#install#Install() abort
  if !executable('pip')
    echohl ErrorMsg
    echo '[vint] ' .
          \ 'pip not found which is required. Please install Python and retry.'
    echohl None
    return 0
  endif

  execute 'silent !pip install --user vim-vint'

  if v:shell_error == 0
    redraw!
    delcommand InstallVint
    call vimrc#buffer#Unset('vint_installed')
    echom '[vint] Installation complete.'
    return 1
  else
    echohl ErrorMsg
    echo '[vint] Failed to install'
    echohl None
    return 0
  endif
endfunction
