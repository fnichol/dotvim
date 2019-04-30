function! s:default_target()
  return get(split(get(filter(systemlist(
        \ 'rustup target list'), 'v:val =~? " (default)$"'), 0, ''), '\s\+'),
        \ 0, '')
endfunction

function! s:component_installed(toolchain, fq_component)
  return index(systemlist(
        \ 'rustup component list --installed --toolchain ' . a:toolchain),
        \ a:fq_component) >= 0
endfunction

function! s:active_component_installed(component)
  return s:component_installed(rust#detect#RlsActiveToolchain(),
        \ a:component == 'rust-src'
        \ ? a:component
        \ : a:component . '-' . s:default_target())
endfunction

function! s:default_target_toolchain_installed(short_toolchain)
  " The toolchain list subcommand returns the default toolchain line with a
  " ` (default)` ending, so we'll strip this out by splitting on whitespace
  return index(map(systemlist(
        \ 'rustup toolchain list'), {idx, val -> split(val, '\s\+')[0]}),
        \ a:short_toolchain . '-' . s:default_target()) >= 0
endfunction

function! rust#detect#RlsActiveToolchain()
  if !exists('g:rust_rls_active_toolchain')
    let g:rust_rls_active_toolchain = get(split(system(
          \ 'rustup show active-toolchain'), '\s\+'), 0, '')
  endif

  return g:rust_rls_active_toolchain
endfunction

function! rust#detect#RlsComponents()
  return ['rls', 'rust-analysis', 'rust-src']
endfunction

function! rust#detect#ClippyComponent()
  return 'clippy'
endfunction

function! rust#detect#RustfmtComponent()
  return 'rustfmt'
endfunction

function! rust#detect#DetectRustupComponent(component)
  let l:var = substitute(a:component, '-', '_', 'g')

  if !exists('g:rust_rustup_component_installed_' . l:var)
    exec 'let g:rust_rustup_component_installed_' . l:var .
          \ ' = s:active_component_installed(a:component)'
  endif

  exec 'return g:rust_rustup_component_installed_' . l:var
endfunction

function! rust#detect#DetectRustupToolchain(toolchain)
  let l:var = substitute(a:toolchain, '-', '_', 'g')

  if !exists('g:rust_rustup_toolchain_installed_' . l:var)
    exec 'let g:rust_rustup_toolchain_installed_' . l:var .
          \ ' = s:default_target_toolchain_installed(a:toolchain)'
  endif

  exec 'return g:rust_rustup_toolchain_installed_' . l:var
endfunction

function! rust#detect#DetectRls()
  if !exists('g:rust_rls_installed')
    for component in rust#detect#RlsComponents()
      if !rust#detect#DetectRustupComponent(component)
        let g:rust_rls_installed = 0
        return g:rust_rls_installed
      endif
    endfor

    if !executable('racer')
      let g:rust_rls_installed = 0
      return g:rust_rls_installed
    endif

    let g:rust_rls_installed = 1
  endif

  return g:rust_rls_installed
endfunction
