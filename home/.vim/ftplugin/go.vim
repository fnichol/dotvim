" Golang source code
"
" This sets some Go-specific settings, including:
" * insert a <Tab> character when typing the Tab key
" * set the tab width to 4 spaces, or a 'short tab'
" * use a pipe character for the <Tab> character, helping to increase
" readability
"
" Thanks to:
" * https://github.com/fatih/vim-go-tutorial#vimrc-improvements-4
" * https://www.reddit.com/r/golang/comments/unc7a/match_go_fmt_to_settings_in_vim_with_4space_tabs/
" * https://hashrocket.com/blog/posts/cool-looking-tabs-in-vim
"
" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

setlocal tabstop=8
setlocal shiftwidth=8
setlocal softtabstop=8
setlocal noexpandtab

if (&encoding ==# "utf-8" && &term isnot# "linux")
  setlocal listchars=tab:\⸽\ ,trail:-,extends:>,precedes:<,nbsp:+
else
  setlocal listchars=tab:\|\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
