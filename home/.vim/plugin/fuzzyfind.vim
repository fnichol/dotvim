if exists('g:did_vimrc_fuzzyfind_loaded')
  finish
endif
let g:did_vimrc_fuzzyfind_loaded = 1

if exists('g:plugs["fzf"]')
  " Map `Ctrl+p` to load a fuzzy file finder
  nnoremap <C-p> :Files<CR>
endif

if exists('g:plugs["ctrlp"]')
  " Ctrl-P ignores
  let g:ctrlp_custom_ignore = '\v[\/](tmp|vendor/bundle|\.git)$'

  " Ctrl-P sets its local working directory the directory of the current file
  let g:ctrlp_working_path_mode = 'a'
endif

if executable('rg')
  " Configure ack.vim to use ripgrep. Note that we're searching hidden
  " directories, but not inside `.git`
  let g:ackprg = 'rg --vimgrep --no-heading --smart-case '
  let g:ackprg .= "--no-ignore --hidden --follow -g '!.git/*'"

  " Set the grep program to use ripgrep
  " Thanks to: https://git.io/fjnOq
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\
        \ --no-ignore\ --hidden\ --follow\ -g\ '!.git/*'
endif
