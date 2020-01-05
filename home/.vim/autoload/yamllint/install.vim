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
    if exists('g:yamllint_installed')
      " Clear any state for next install check
      unlet g:yamllint_installed
    endif
    echom '[yamllint] Installation complete.'
    return 1
  else
    echohl ErrorMsg
    echo '[yamllint] Failed to install'
    echohl None
    return 0
  endif
endfunction
