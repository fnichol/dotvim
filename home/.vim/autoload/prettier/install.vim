function! prettier#install#Install() abort
  if !executable('npm')
    echohl ErrorMsg
    echo '[prettier] ' .
          \ 'npm not found which is required. Please install Node.js and retry.'
    echohl None
    return 0
  endif

  execute 'silent !npm install --global prettier'

  if v:shell_error == 0
    redraw!
    delcommand InstallPrettier
    call vimrc#buffer#Unset('prettier_installed')
    echom '[prettier] Installation complete.'
    return 1
  else
    echohl ErrorMsg
    echo '[prettier] Failed to install'
    echohl None
    return 0
  endif
endfunction
