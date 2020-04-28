if exists('g:did_vimrc_spell_loaded')
  finish
endif
let g:did_vimrc_spell_loaded = 1

" Spelling

" Set spellchecking languages to be used in priority order
set spelllang=en_us,en_ca

" Enable spell checking by default
set spell

" Customize the display of words not recognized by the spellchecker
highlight clear SpellBad
highlight SpellBad
      \ term=underline,italic cterm=underline,italic gui=underline,italic
" Customize the display of words that should be capitalized
highlight clear SpellCap
highlight SpellCap
      \ term=italic cterm=italic gui=italic
" Customize the display of words that are recognized by the spellchecker as
" rare (i.e. hardly ever used)
highlight clear SpellRare
highlight SpellRare
      \ term=underline,italic cterm=underline,italic gui=underline,italic
highlight clear SpellLocal
" Customize the display of words that are recognized by the spellchecker that
" are used in another region
highlight SpellLocal
      \ term=underline cterm=underline gui=underline

" Check the status of spellchecking
command! -nargs=0 -bar StatusSpellCheck :call vimrc#spell#StatusSpellCheck()
" Map leader ss to check the status of spell checking
map <leader>ss :StatusSpellCheck<CR>
" Toggle spellchecking on and off
command! -nargs=0 -bar ToggleSpellCheck :call vimrc#spell#ToggleSpellCheck()
" Map leader ts to toggle spell checking on and off
map <leader>ts :ToggleSpellCheck<CR>
