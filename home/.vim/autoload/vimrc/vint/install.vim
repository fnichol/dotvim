function! vimrc#vint#install#Install() abort
  if executable('pip3')
    let l:pip = 'pip3'
  elseif executable('pip')
    let l:pip = 'pip'
  else
    echohl ErrorMsg
    echo '[vint] ' .
          \ 'neither pip3 nor pip not found which is required. ' .
          \ 'Please install Python and retry.'
    echohl None
    return 0
  endif

  let l:stable_version = get(split(get(filter(systemlist(
        \ l:pip . ' search vim-vint'), 'v:val =~? "^vim-vint "'), 0)), 1)

  " The current 0.3.x stable version of vint has issues linting from `stdin`,
  " so until the next version is released, install the latest prerelease
  " version instead.
  "
  " See https://github.com/Vimjas/vint/issues/305
  if l:stable_version ==? '(0.3.21)'
    execute 'silent !' . l:pip . ' install --user --pre vim-vint'
  else
    execute 'silent !' . l:pip . ' install --user vim-vint'
  endif

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
