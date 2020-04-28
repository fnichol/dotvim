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
if exists('b:did_vimrc_ftplugin')
  finish
endif
let b:did_vimrc_ftplugin = 1

setlocal tabstop=8
setlocal shiftwidth=8
setlocal softtabstop=8
setlocal noexpandtab

" Check the status of vim-go's gopls
command! -nargs=0 -bar -buffer StatusGopls call vimrc#go#StatusGopls()
" Toggle vim-go's gopls on and off
command! -nargs=0 -bar -buffer ToggleGopls call vimrc#go#ToggleGopls()
