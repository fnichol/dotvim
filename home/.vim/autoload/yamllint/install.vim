function! yamllint#install#Install() abort
  if !executable('pip3')
    echohl ErrorMsg
    echo '[yamllint] ' .
          \ 'pip3 not found which is required. Please install Python 3 and retry.'
    echohl None
    return 0
  endif

  execute 'silent !pip3 install --user yamllint'

  if v:shell_error == 0
    redraw!
    delcommand InstallYamllint
    call vimrc#buffer#Unset('yamllint_installed')
    echom '[yamllint] Installation complete.'
    return 1
  else
    echohl ErrorMsg
    echo '[yamllint] Failed to install'
    echohl None
    return 0
  endif
endfunction
