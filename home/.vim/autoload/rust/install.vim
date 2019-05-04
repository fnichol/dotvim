function! s:rustup_is_missing(title) abort
  if !executable('rustup')
    echohl ErrorMsg
    echo '[' . a:title' ] ' .
          \ 'rustup not found which is required. Please install and retry.'
    echohl None
    return 1
  else
    return 0
  endif
endfunction

function! s:cargo_is_missing(title) abort
  if !executable('cargo')
    echohl ErrorMsg
    echo '[' . a:title' ] ' .
          \ 'cargo not found which is required. Please install and retry.'
    echohl None
    return 1
  else
    return 0
  endif
endfunction

function! s:rustup_component_add(component) abort
  if s:rustup_is_missing('component: ' . a:component)
    return 0
  endif

  execute 'silent !rustup component add ' . a:component

  let l:var = 'rust_rustup_component_installed_'
  let l:var .= substitute(a:component, '-', '_', 'g')
  if exists('g:' . l:var)
    unlet g:[l:var]
  endif

  if rust#detect#DetectRustupComponent(a:component)
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

function! s:cargo_nightly_install(name) abort
  if s:cargo_is_missing('install: '. a:name)
    return 0
  endif

  if !rust#detect#DetectRustupToolchain('nightly')
    if !s:rustup_toolchain_install('nightly')
      return 0
    endif
  endif

  execute '!cargo +nightly install ' . a:name
  echom '[' . a:name . '] Installation complete.'
endfunction

function! s:rustup_toolchain_install(toolchain) abort
  if s:rustup_is_missing('toolchain: ' . a:toolchain)
    return 0
  endif

  execute 'silent !rustup toolchain install ' . a:toolchain

  let l:var = 'rust_rustup_toolchain_installed_'
  let l:var .= substitute(a:toolchain, '-', '_', 'g')
  if exists('g:' . l:var)
    unlet g:[l:var]
  endif

  if rust#detect#DetectRustupToolchain(a:toolchain)
    redraw!
    return 1
  else
    echohl ErrorMsg
    echo '[rustup] ' .
          \ 'Failed to install toolchain ' . a:toolchain
    echohl None
    return 0
  endif
endfunction

function! rust#install#InstallClippy() abort
  let l:component = rust#detect#ClippyComponent()
  if s:rustup_component_add(l:component)
    " Remove command
    delcommand InstallClippy
    echom '[' . l:component . '] Installation complete.'
  endif
endfunction

function! rust#install#InstallRustfmt() abort
  let l:component = rust#detect#RustfmtComponent()
  if s:rustup_component_add(l:component)
    " Remove command
    delcommand InstallRustfmt
    echom '[' . l:component . '] Installation complete.'
  endif
endfunction

function! rust#install#InstallRls() abort
  if s:rustup_is_missing('rls')
    return 0
  endif

  for component in rust#detect#RlsComponents()
    if !rust#detect#DetectRustupComponent(component)
      if !s:rustup_component_add(component)
        return 0
      endif
    endif
  endfor

  if !executable('racer')
    if !s:cargo_nightly_install('racer')
      return 0
    endif
  endif

  " Remove command
  delcommand InstallRls
  if exists('g:rust_rls_installed')
    " Clear any state for next detect
    unlet g:rust_rls_installed
  endif
  echom '[rls] Installation complete.'
endfunction
