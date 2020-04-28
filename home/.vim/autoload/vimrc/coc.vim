" Load list of coc.nvim extensions from a standaline file with a simple DSL
" which mimics vim-plug
function! vimrc#coc#Load(source_file) abort
  let g:coc_global_extensions = []

  if filereadable(expand(a:source_file))
    command! -nargs=1 -bar CocExtension call s:coc_extension(<args>)
    execute "source " . expand(a:source_file)
    delcommand CocExtension
  endif
endfunction

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

function! s:coc_extension(extension)
  if !(index(g:coc_global_extensions, a:extension) >= 0)
    call add(g:coc_global_extensions, a:extension)
  endif
endfunction
