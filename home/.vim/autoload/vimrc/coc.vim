" Install and update extensions in a synchronous/blocking way which can be
" used to update via the command line
function! vimrc#coc#UpdateThenQuit() abort
  if exists('g:plugs["coc.nvim"]')
    call vimrc#coc#Load('~/.vim/coc-extensions.vim')
    call vimrc#coc#start()
    " Thanks to: https://git.io/J3jJv
    call CocActionAsync('updateExtensions', v:false,
          \ function('vimrc#coc#UpdateThenQuitCallback'))
  endif
endfunction

function! vimrc#coc#UpdateThenQuitCallback(err, ...) abort
  if a:err
    echo a:err
  else
    execute 'qall'
  endif
endfunction

" Load list of coc.nvim extensions from a standaline file with a simple DSL
" which mimics vim-plug
function! vimrc#coc#Load(source_file) abort
  let g:coc_global_extensions = []

  if filereadable(expand(a:source_file))
    command! -nargs=1 -bar CocExtension call s:coc_extension(<args>)
    execute 'source ' . expand(a:source_file)
    delcommand CocExtension
  endif
endfunction

" Determines whether or not coc.nvim is running
function! vimrc#coc#IsRunning() abort
  return exists('*coc#client#is_running') && coc#client#is_running('coc')
endfunction

" Check the status of code completion
function! vimrc#coc#StatusCoc() abort
  if vimrc#coc#IsRunning()
    echo '[status] coc.nvim completion enabled (+)'
  else
    echo '[status] coc.nvim completion disabled (-)'
  endif
endfunction

" Toggle code completion on and off
function! vimrc#coc#ToggleCoc() abort
  if coc#client#is_running('coc')
    call vimrc#coc#stop()
    echo '[toggle] coc.nvim completion disabled (-)'
  else
    call vimrc#coc#start()
    echo '[toggle] coc.nvim completion enabled (+)'
  endif
endfunction

function! vimrc#coc#start() abort
  call coc#rpc#start_server()
  if exists('g:vimrc_coc_start_callbacks')
    for func in g:vimrc_coc_start_callbacks
      execute 'call ' . func . '()'
    endfo
  endif
endfunction

function! vimrc#coc#stop() abort
  call coc#rpc#stop()
  if exists('g:vimrc_coc_stop_callbacks')
    for func in g:vimrc_coc_stop_callbacks
      execute 'call ' . func . '()'
    endfo
  endif
endfunction

" Determines whether or not an extension is in the global extensions
function! vimrc#coc#DetectExtension(extension) abort
  return index(g:coc_global_extensions, a:extension) >= 0
endfunction

function! vimrc#coc#RegisterStartCallback(func) abort
  if !exists('g:vimrc_coc_start_callbacks')
    let g:vimrc_coc_start_callbacks = []
  endif

  if !(index(g:vimrc_coc_start_callbacks, a:func) >= 0)
    call add(g:vimrc_coc_start_callbacks, a:func)
  endif
endfunction

function! vimrc#coc#RegisterStopCallback(func) abort
  if !exists('g:vimrc_coc_stop_callbacks')
    let g:vimrc_coc_stop_callbacks = []
  endif

  if !(index(g:vimrc_coc_stop_callbacks, a:func) >= 0)
    call add(g:vimrc_coc_stop_callbacks, a:func)
  endif
endfunction

function! s:coc_extension(extension) abort
  if !vimrc#coc#DetectExtension(a:extension)
    call add(g:coc_global_extensions, a:extension)
  endif
endfunction
