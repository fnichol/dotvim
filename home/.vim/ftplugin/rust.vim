" Only do this when not done yet for this buffer
if exists('b:did_vimrc_ftplugin')
  finish
endif
let b:did_vimrc_ftplugin = 1

" https://github.com/rust-dev-tools/fmt-rfcs/blob/master/guide/guide.md
setlocal colorcolumn=100

" Use the `--all-targets` option with running either `cargo check` or `cargo
" clippy`
let b:ale_rust_cargo_check_all_targets = 1

" Use the `--tests` option when running either `cargo check` or `cargo
" clippy`
let b:ale_rust_cargo_check_tests = 1

if !exists('b:ale_linters')
  let b:ale_linters = []
endif

" Check for RLS
if rust#detect#DetectRls()
  let b:ale_linters += ['rls']
else
  " Setup an `:InstallRls` command if the software components for RLS are not
  " currently installed.
  command! -nargs=0 -bar InstallRls call rust#install#InstallRls()
endif

" Check for Cargo
if executable('cargo')
  let b:ale_linters += ['cargo']
endif

" Check for Rustfmt
if rust#detect#DetectRustupComponent(rust#detect#RustfmtComponent())
  " Runs Rustfmt on buffer write
  let b:rustfmt_autosave = 1
else
  " Setup an `:InstallRustfmt` command if Rustfmt is not currently installed
  command! -nargs=0 -bar InstallRustfmt call rust#install#InstallRustfmt()
endif

" Check for Clippy
if rust#detect#DetectRustupComponent(rust#detect#ClippyComponent())
  " Use `cargo clippy` over `cargo check` (Clippy is a super-set of
  " `cargo check`)
  let b:ale_rust_cargo_use_clippy = 1
else
  " Setup an `:InstallClippy` command if Clippy is not currently installed
  command! -nargs=0 -bar InstallClippy call rust#install#InstallClippy()
endif

" Set the RLS toolchain based on the currently active toolchain
let b:ale_rust_rls_toolchain = rust#detect#RlsActiveToolchain()
