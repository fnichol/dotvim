let s:rls_components = ['rls-preview', 'rust-analysis', 'rust-src']
let s:rustfmt_component = 'rustfmt-preview'

function! FileTypeRust()
  " Runs rustfmt on buffer write, if rustfmt is installed
  if s:rustup_installed(s:rustfmt_component)
    let g:rustfmt_autosave = 1
  endif
endfunction

function s:rustup_installed(component)
  let l:matches = systemlist('rustup component list | ' .
        \ ' grep -E "\((default|installed)\)$" | ' .
        \ ' grep "^' . a:component . '"')
  if len(l:matches) > 0
    return 1
  else
    return 0
  endif
endfunction

function s:rls_installed()
  for component in s:rls_components
    if !s:rustup_installed(component)
      return 0
    endif
  endfor

  return 1
endfunction

function! s:rustup_component_add(component)
  if !executable('rustup')
    echohl ErrorMsg
    echo '[rustup] ' .
          \ 'rustup not found which is required. Please install and retry.'
    echohl None
    return 0
  endif

  execute 'silent !rustup component add ' . a:component

  if s:rustup_installed(a:component)
    redraw!
    return 1
  else
    echohl ErrorMsg
    echo '[rustup] ' .
          \ 'Failed to add component ' . a:component
    echohl None
    return 0
  endif
endfunction

function! s:rustfmt_install()
  if s:rustup_component_add(s:rustfmt_component)
    " Remove command
    delcommand InstallRustfmt
    " Enable rustfmt on buffer write
    let g:rustfmt_autosave = 1

    echom '[rustfmt] Installation complete.'
  endif
endfunction

function! s:rls_install()
  if !executable('rustup')
    echohl ErrorMsg
    echo '[rls] ' .
          \ 'rustup not found which is required. Please install and retry.'
    echohl None
    return 0
  endif

  for component in s:rls_components
    if !s:rustup_installed(component)
      if !s:rustup_component_add(component)
        return 0
      endif
    endif
  endfor

  if !exists('racer')
    if s:cargo_nightly_install('racer')
      return 1
    endif
  endif

  echom '[rls] Installation complete.'

  delcommand InstallRls
  command! -nargs=0 -bar RlsEnable call s:rls_enable()
endfunction

function! s:rls_enable()
  call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': { server_info->['rustup', 'run', 'stable', 'rls']},
        \ 'whitelist': ['rust']
        \ })
  delcommand RlsEnable
endfunction

function! s:cargo_nightly_install(name)
  if !executable('cargo')
    echohl ErrorMsg
    echo '[' . a:name . ' install] ' .
          \ 'cargo not found which is required. Please install and retry.'
    echohl None
    return 1
  endif

  execute '!cargo +nightly install ' . a:name
  echom '[' . a:name . ' install] ' .
        \ 'Installation complete.'
  return 0
endfunction


" Setup an `:InstallRustfmt` command if Rustfmt is not currently installed
if !s:rustup_installed(s:rustfmt_component)
  command! -nargs=0 -bar InstallRustfmt call s:rustfmt_install()
endif

" Setup an `:InstallRls` command if the software components for RLS are not
" currently installed. Otherwise, setup an `RlsEnable` which will laazily
" activate the feature.
if s:rls_installed()
  " As of November 2017, RLS doesn't have support for Cargo workspaces so is
  " not a viable solution all the time (for me, at least). Therefore, delay
  " registering the service until `:RlsEnable` is called.
  command! -nargs=0 -bar RlsEnable call s:rls_enable()
else
  command! -nargs=0 -bar InstallRls call s:rls_install()
endif
