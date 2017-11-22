function! FileTypeRust()
  " Runs rustfmt on buffer write, if rustfmt exists on $PATH
  if executable('rustfmt')
    let g:rustfmt_autosave = 1
  endif

  if executable('rusty-tags')
    if exists('$RUST_SRC_PATH')
      setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
    else
      setlocal tags=./rusty-tags.vi;/
    endif
    command! RustyTags silent! execute
          \ "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&"
          \ <bar> redraw!
    autocmd BufWrite *.rs :RustyTags
  endif
endfunction

if !executable('rustfmt')
  command! -nargs=0 -bar InstallRustfmt call s:install_rustfmt()
endif

if !executable('rusty-tags')
  command! -nargs=0 -bar InstallRustyTags call s:install_rusty_tags()
endif

let s:rls = 0
if executable('rustup')
  silent! !rustup run nightly rls --version | redraw!
  if v:shell_error == 0
    let s:rls = 1
  endif
endif

if s:rls
  " As of November 2017, RLS doesn't have support for Cargo workspaces so is
  " not a viable solution all the time (for me, at least). Therefore, delay
  " registering the service until `:RlsEnable` is called.
  command! -nargs=0 -bar RlsEnable call s:rls_enable()
else
  command! -nargs=0 -bar InstallRls call s:install_rls()
endif

function! s:cargo_install(name)
  if !executable('cargo')
    echohl ErrorMsg
    echo '[' . a:name . ' install] ' .
          \ 'cargo not found which is required. Please install and retry.'
    echohl None
    return 1
  endif

  execute '!cargo install ' . a:name
  echom '[' . a:name . ' install] ' .
        \ 'Installation complete.'
  return 0
endfunction

function! s:install_rls()
  if !executable('rustup')
    echohl ErrorMsg
    echo '[rls install] ' .
          \ 'rustup not found which is required. Please install and retry.'
    echohl None
    return 1
  endif

  silent !rustup self update
  silent !rustup install nightly
  silent !rustup update nightly
  silent !rustup component add rls-preview --toolchain nightly
  silent !rustup component add rust-analysis --toolchain nightly
  silent !rustup component add rust-src --toolchain nightly
  silent !rustup component add rust-src

  if !exists('racer')
    if s:cargo_install('racer')
      return 1
    endif
  endif

  delcommand InstallRls
endfunction

function! s:install_rustfmt()
  if s:cargo_install('rustfmt')
    delcommand InstallRustfmt
  endif
endfunction

function! s:install_rusty_tags()
  if s:cargo_install('rusty-tags')
    delcommand InstallRustyTags
  endif
endfunction

function! s:rls_enable()
  call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': { server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust']
        \ })
  delcommand RlsEnable
endfunction
