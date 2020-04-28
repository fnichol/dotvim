function! s:default_target() abort
  let l:active = vimrc#rust#detect#RlsActiveToolchain()

  " Use the current active toolchain to get a list of installed components, of
  " which `rustc` should be installed. Knowing this, we'll strip off `rustc-`
  " and what we're left with should be the full target triple of the active
  " toolchain.
  return substitute(get(filter(systemlist(
        \ 'rustup component list --installed --toolchain '. l:active),
        \ 'v:val =~? "^rustc-"'), 0, ''), 'rustc-', '', '')
endfunction

function! s:component_installed(toolchain, fq_component) abort
  return index(systemlist(
        \ 'rustup component list --installed --toolchain ' . a:toolchain),
        \ a:fq_component) >= 0
endfunction

function! s:active_component_installed(component) abort
  return s:component_installed(vimrc#rust#detect#RlsActiveToolchain(),
        \ a:component ==? 'rust-src'
        \ ? a:component
        \ : a:component . '-' . s:default_target())
endfunction

function! s:default_target_toolchain_installed(short_toolchain) abort
  " The toolchain list subcommand returns the default toolchain line with a
  " ` (default)` ending, so we'll strip this out by splitting on whitespace
  return index(map(systemlist(
        \ 'rustup toolchain list'), {idx, val -> split(val, '\s\+')[0]}),
        \ a:short_toolchain . '-' . s:default_target()) >= 0
endfunction

function! vimrc#rust#detect#RlsActiveToolchain() abort
  let l:var = 'rust_rls_active_toolchain'
  let l:buffer = bufnr('')

  if !vimrc#buffer#Exists(l:var)
    call vimrc#buffer#Set(l:buffer, l:var, get(split(system(
          \ 'rustup show active-toolchain'), '\s\+'), 0, ''))
  endif

  return vimrc#buffer#Var(l:buffer, l:var)
endfunction

function! vimrc#rust#detect#RlsComponents() abort
  return ['rls', 'rust-analysis', 'rust-src']
endfunction

function! vimrc#rust#detect#ClippyComponent() abort
  return 'clippy'
endfunction

function! vimrc#rust#detect#RustfmtComponent() abort
  return 'rustfmt'
endfunction

function! vimrc#rust#detect#DetectRustupComponent(component) abort
  let l:var = 'rust_rustup_component_installed_'
  let l:var .= substitute(a:component, '-', '_', 'g')
  let l:buffer = bufnr('')

  if !vimrc#buffer#Exists(l:var)
    let l:is_found = s:active_component_installed(a:component)

    call vimrc#buffer#Set(l:buffer, l:var, l:is_found)
  endif

  return vimrc#buffer#Var(l:buffer, l:var)
endfunction

function! vimrc#rust#detect#DetectRustupToolchain(toolchain) abort
  let l:var = 'rust_rustup_toolchain_installed_'
  let l:var .= substitute(a:toolchain, '-', '_', 'g')
  let l:buffer = bufnr('')

  if !vimrc#buffer#Exists(l:var)
    let l:is_found = s:default_target_toolchain_installed(a:toolchain)

    call vimrc#buffer#Set(l:buffer, l:var, l:is_found)
  endif

  return vimrc#buffer#Var(l:buffer, l:var)
endfunction

function! vimrc#rust#detect#DetectRls() abort
  let l:var = 'rust_rls_installed'
  let l:buffer = bufnr('')

  if !vimrc#buffer#Exists(l:var)
    for component in vimrc#rust#detect#RlsComponents()
      if !vimrc#rust#detect#DetectRustupComponent(component)
        call vimrc#buffer#Set(l:buffer, l:var, 0)
        return vimrc#buffer#Var(l:buffer, l:var)
      endif
    endfor

    if !executable('racer')
      call vimrc#buffer#Set(l:buffer, l:var, 0)
      return vimrc#buffer#Var(l:buffer, l:var)
    endif

    call vimrc#buffer#Set(l:buffer, l:var, 1)
  endif

  return vimrc#buffer#Var(l:buffer, l:var)
endfunction
