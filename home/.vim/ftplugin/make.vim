" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

setlocal tabstop=8
setlocal softtabstop=0
setlocal shiftwidth=8
setlocal noexpandtab
setlocal listchars=tab:\|\ ,trail:-,extends:>,precedes:<,nbsp:+
