" Only do this when not done yet for this buffer
if exists('b:did_vimrc_ftplugin')
  finish
endif
let b:did_vimrc_ftplugin = 1

" https://github.com/rust-dev-tools/fmt-rfcs/blob/master/guide/guide.md
setlocal colorcolumn=100

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
  " TODO(fnichol): find a reasonable way to use Clippy with coc.nvim
  "
  " Use `cargo clippy` over `cargo check` (Clippy is a super-set of
  " `cargo check`)
  " let b:ale_rust_cargo_use_clippy = 1
else
  " Setup an `:InstallClippy` command if Clippy is not currently installed
  command! -nargs=0 -bar InstallClippy call rust#install#InstallClippy()
endif
