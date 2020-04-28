if exists('g:did_vimrc_statusline_loaded')
  finish
endif
let g:did_vimrc_statusline_loaded = 1

function! StatusLineCoc()
  let l:status = coc#status()
  return strlen(l:status) > 0 ? ' {' . l:status . '}' : ''
endfunction

" Set the status line info at bottom of screen
set statusline=
" Buffer number
set statusline+=[%n]
" Path to the file in the buffer
set statusline+=\ %<%.99f
" Buffer flags: help buffer, preview window, modified, read-only, file type
set statusline+=\ %h%w%m%r%y
" coc.nvim status, if installed and activated
set statusline+=%{exists('*coc#status')?StatusLineCoc():''}
set statusline+=\ %{get(b:,'coc_current_function','')}
" Separation point between left and right aligned items
set statusline+=%=
" Cursor location: line number, column number, virtual column number
set statusline+=%-16(\ %l,%c-%v\ %)
" Percentage through the file
set statusline+=%P
