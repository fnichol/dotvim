" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

setlocal colorcolumn=80

setlocal tabstop=8
setlocal softtabstop=0
setlocal shiftwidth=8
setlocal noexpandtab

if (&encoding ==# "utf-8" && &term isnot# "linux")
  setlocal listchars=tab:\⸽\ ,trail:-,extends:>,precedes:<,nbsp:+
else
  setlocal listchars=tab:\|\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
