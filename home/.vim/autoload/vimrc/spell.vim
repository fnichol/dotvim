" Check the status of spellchecking
function! vimrc#spell#StatusSpellCheck() abort
  if &spell
    echo '[status] Spell check enabled (+)'
  else
    echo '[status] Spell check disabled (-)'
  endif
endfunction

" Toggle spellchecking on and off
function! vimrc#spell#ToggleSpellCheck() abort
  set spell!
  if &spell
    echo '[toggle] Spell check enabled (+)'
  else
    echo '[toggle] Spell check disabled (-)'
  endif
endfunction
