" Only do this when not done yet for this buffer
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

setlocal colorcolumn=80

if !exists('b:ale_fixers')
  let b:ale_fixers = []
endif

if executable('shfmt')
  let b:ale_fixers += ['shfmt']
  " By default, use Google-style formatting
  " (src: https://google.github.io/styleguide/shell.xml)
  let b:ale_sh_shfmt_options = '-i 2 -ci -bn'
endif

if !exists('b:ale_linters')
  let b:ale_linters = []
endif

" Lints shell files using `bash -n`, enable by default
let b:ale_linters += ['shell']

if executable('shellcheck')
  let b:ale_linters += ['shellcheck']
  " Disable changing directories before checking buffers with ShellCheck--this
  " means all `shellcheck source=...` directives are relative to the root of
  " the project, where `vim` is launched.
  let b:ale_sh_shellcheck_change_directory = 0
endif

if IsBashLanguageServerInstalled()
  let b:ale_linters += ['language_server']
else
  command! -nargs=0 -bar InstallBashLanguageServer
        \ call bash_language_server#Install()
endif
