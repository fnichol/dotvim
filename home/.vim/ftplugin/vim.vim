" Only do this when not done yet for this buffer
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

setlocal colorcolumn=80

function! IsVintInstalled()
  if !exists('g:vint_installed')
    let g:vint_installed = executable('vint')
  end

  return g:vint_installed
endfunction

if !exists('b:ale_linters')
  let b:ale_linters = []
endif

if IsVintInstalled()
  let b:ale_linters += ['vint']
else
  command! -nargs=0 -bar InstallVint call vint#Install()
endif
