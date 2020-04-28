function! vimrc#vim_markdown_composer#install#Install() abort
  if !executable('cargo')
    echohl ErrorMsg
    echo '[vim-markdown-composer] ' .
          \ 'cargo not found which is required. Please install and retry.'
    echohl None
    return 0
  endif

  execute 'cd' fnameescape(g:plugs['vim-markdown-composer']['dir'])

  if has('nvim')
    execute '!cargo build --release'
  else
    execute '!cargo build --release --no-default-features --features json-rpc'
  endif
  let l:shell_error = v:shell_error
  redraw!

  cd -

  if l:shell_error == 0
    delcommand InstallVimMarkdownComposer
    call vimrc#buffer#Unset('vim_markdown_composer_installed')
    echom '[vim-markdown-composer] Installation complete.'
    return 1
  else
    echohl ErrorMsg
    echo '[vim-markdown-composer] Failed to install'
    echohl None
    return 0
  endif
endfunction
