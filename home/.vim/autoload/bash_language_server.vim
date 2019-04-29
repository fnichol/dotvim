function! bash_language_server#Install() abort
  if !executable('npm')
    echohl ErrorMsg
    echo '[bash-language-server] ' .
          \ 'npm not found which is required. Please install Node.js and retry.'
    echohl None
    return 0
  endif

  execute 'silent !npm install --global bash-language-server'

  if v:shell_error == 0
    redraw!
    delcommand InstallBashLanguageServer
    if exists('g:bash_language_server_installed')
      " Clear any state for next install check
      unlet g:bash_language_server_installed
    endif
    echom '[bash-language-server] Installation complete.'
    return 1
  else
    echohl ErrorMsg
    echo '[bash-language-server] Failed to install'
    echohl None
    return 0
  endif
endfunction