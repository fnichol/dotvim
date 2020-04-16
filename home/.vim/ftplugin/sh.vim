" Only do this when not done yet for this buffer
if exists('b:did_vimrc_ftplugin')
  finish
endif
let b:did_vimrc_ftplugin = 1

setlocal colorcolumn=80

" TODO(fnichol): Find a way to set relative source path to the root of the
" project
"
" if executable('shellcheck')
"   let b:ale_linters += ['shellcheck']
"   " Disable changing directories before checking buffers with ShellCheck--this
"   " means all `shellcheck source=...` directives are relative to the root of
"   " the project, where `vim` is launched.
"   let b:ale_sh_shellcheck_change_directory = 0
" endif
