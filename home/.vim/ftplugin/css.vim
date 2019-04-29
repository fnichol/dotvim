" Only do this when not done yet for this buffer
if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

if !exists('b:ale_fixers')
  let b:ale_fixers = []
endif

if IsPrettierInstalled()
  let b:ale_fixers += ['prettier']
else
  command! -nargs=0 -bar InstallPrettier call prettier#Install()
endif
