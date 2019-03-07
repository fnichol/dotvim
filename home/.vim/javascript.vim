let s:prettier_binary = 'prettier'
let g:javascript_ft_loaded = 0

function! FileTypeJavascript()
  if g:javascript_ft_loaded
    return 1
  endif

  if s:prettier_installed()
    call s:add_prettier_ale_fixers()
  endif

  let g:javascript_ft_loaded = 1
endfunction

function! s:add_prettier_ale_fixers()
  let g:ale_fixers['javascript'] = ['prettier']
  let g:ale_fixers['css'] = ['prettier']
endfunction

function! s:prettier_installed()
  if !executable(s:prettier_binary)
    return 0
  else
    return 1
  endif
endfunction

function! s:prettier_install()
  if !executable('npm')
    echohl ErrorMsg
    echo '[prettier] ' .
          \ 'npm not found which is required. Please install Node.js and retry.'
    echohl None
    return 0
  endif

  execute 'silent !npm install --global ' . s:prettier_binary

  if v:shell_error == 0
    redraw!
    delcommand InstallPrettier
    echom '[prettier] Installation complete.'
    call s:add_prettier_ale_fixers()
    return 1
  else
    echohl ErrorMsg
    echo '[prettier] ' .
          \ 'Failed to install toolchain ' . a:toolchain
    echohl None
    return 0
  endif
endfunction

if !s:prettier_installed()
  command! -nargs=0 -bar InstallPrettier call s:prettier_install()
endif
