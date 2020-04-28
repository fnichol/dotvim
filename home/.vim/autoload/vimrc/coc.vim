" Check the status of code completion
function! vimrc#coc#StatusCocCompletion() abort
  if coc#client#is_running('coc')
    echo '[status] coc.nvim completion enabled (+)'
  else
    echo '[status] coc.nvim completion disabled (-)'
  endif
endfunction

" Toggle code completion on and off
function! vimrc#coc#ToggleCocCompletion() abort
  if coc#client#is_running('coc')
    call coc#rpc#stop()
    echo '[toggle] coc.nvim completion disabled (-)'
  else
    call coc#rpc#start_server()
    echo '[toggle] coc.nvim completion enabled (+)'
  endif
endfunction
