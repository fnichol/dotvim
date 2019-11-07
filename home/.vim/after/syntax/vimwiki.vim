if exists('b:did_vimrc_syntax')
  finish
endif
let b:did_vimrc_syntax = 1

" Override the syntax of `vimwiki` mode to `markdown` which displays all wiki
" pages identically to normal Markdown buffers.
"
" Huge thanks to the tip at:
" https://www.gitmemory.com/issue/tbabej/taskwiki/214/491438668
set syntax=markdown
