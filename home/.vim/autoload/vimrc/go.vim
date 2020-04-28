" Toggle vim-go's gopls on and off
function! vimrc#go#ToggleGopls() abort
  if g:go_gopls_enabled
    let g:go_gopls_enabled = 0
    call go#lsp#Exit()
    echo '[toggle] gopls completion disabled (-)'
  else
    let g:go_gopls_enabled = 1
    echo '[toggle] gopls completion enabled (+)'
  endif
endfunction

" Check the status of vim-go's gopls
function! vimrc#go#StatusGopls() abort
  if g:go_gopls_enabled
    echo '[status] gopls completion enabled (+)'
  else
    echo '[status] gopls completion disabled (-)'
  endif
endfunction
