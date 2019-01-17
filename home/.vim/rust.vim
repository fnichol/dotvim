let s:rls_components = ['rls', 'rust-analysis', 'rust-src']
let s:rustfmt_component = 'rustfmt'
let s:clippy_component = 'clippy'
let g:rust_ft_loaded = 0

function! FileTypeRust()
  " Early return if this file type block has been executed once already
  if g:rust_ft_loaded
    return 1
  endif

  " Runs rustfmt on buffer write, if rustfmt is installed
  if s:rustup_installed(s:rustfmt_component)
    let g:rustfmt_autosave = 1
  endif

  " Use `cargo clippy` over `cargo check` if Clippy is present (Clippy is a
  " super-set of `cargo check`)
  let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')

  " Set the RLS toolchain based on the currently active toolchain, unless we
  " cannot determine the toolchain's short name
  let l:active = split(system('rustup show active-toolchain'), '-')[0]
  if index(['stable', 'beta', 'nightly'], l:active) >=? 0
    let g:ale_rust_rls_toolchain = l:active
  endif

  " Initialize the ALE linters list for Rust
  let g:ale_linters['rust'] = []
  " If RLS is installed, add RLS as a ALE linter for Rust
  if s:rls_installed()
    let g:ale_linters['rust'] += ['rls']
  endif
  " If the `cargo` binary is present, add Cargo as a ALE linter for Rust
  if executable('cargo')
    let g:ale_linters['rust'] += ['cargo']
  endif

  " Remember that this file type block has been executed once before
  let g:rust_ft_loaded = 1
endfunction

function! s:rustup_installed(component)
  let l:matches = systemlist('rustup component list | ' .
        \ ' grep -E "\((default|installed)\)$" | ' .
        \ ' grep "^' . a:component . '"')
  if len(l:matches) > 0
    return 1
  else
    return 0
  endif
endfunction

function! s:rustup_toolchain_installed(toolchain)
  let l:matches = systemlist('rustup toolchain list | ' .
        \ ' grep "^' . a:toolchain . '"')
  if len(l:matches) > 0
    return 1
  else
    return 0
  endif
endfunction

function! s:rls_installed()
  for component in s:rls_components
    if !s:rustup_installed(component)
      return 0
    endif
  endfor

  if !executable('racer')
    return 0
  endif

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

function! s:rustup_toolchain_install(toolchain)
  if !executable('rustup')
    echohl ErrorMsg
    echo '[rustup] ' .
          \ 'rustup not found which is required. Please install and retry.'
    echohl None
    return 0
  endif

  execute 'silent !rustup toolchain install ' . a:toolchain

  if s:rustup_toolchain_installed(a:toolchain)
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

function! s:clippy_install()
  if s:rustup_component_add(s:clippy_component)
    " Remove command
    delcommand InstallClippy
    " Enable Clippy as Rust ALE linter
    let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')

    echom '[cargo-clippy] Installation complete.'
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

  if !executable('racer')
    if !s:cargo_nightly_install('racer')
      return 0
    endif
  endif

  echom '[rls] Installation complete.'

  delcommand InstallRls
endfunction

function! s:cargo_nightly_install(name)
  if !executable('cargo')
    echohl ErrorMsg
    echo '[' . a:name . ' install] ' .
          \ 'cargo not found which is required. Please install and retry.'
    echohl None
    return 0
  endif

  if !s:rustup_toolchain_installed('nightly')
    if !s:rustup_toolchain_install('nightly')
      return 0
    endif
  endif

  execute '!cargo +nightly install ' . a:name
  echom '[' . a:name . ' install] ' .
        \ 'Installation complete.'
  return 1
endfunction


" Setup an `:InstallRustfmt` command if Rustfmt is not currently installed
if !s:rustup_installed(s:rustfmt_component)
  command! -nargs=0 -bar InstallRustfmt call s:rustfmt_install()
endif

" Setup an `:InstallClippy` command if Clippy is not currently installed
if !s:rustup_installed(s:clippy_component)
  command! -nargs=0 -bar InstallClippy call s:clippy_install()
endif

" Setup an `:InstallRls` command if the software components for RLS are not
" currently installed.
if !s:rls_installed()
  command! -nargs=0 -bar InstallRls call s:rls_install()
endif
