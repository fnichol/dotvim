if exists('g:did_vimrc_coc_loaded') || !exists('g:plugs["coc.nvim"]')
  finish
endif
let g:did_vimrc_coc_loaded = 1

" Disable Coc at startup
let g:coc_start_at_startup = 0

" Declare Coc global extensions which will be automatically installed
call vimrc#coc#Load('~/.vim/coc-extensions.vim')

" Some servers have issues with backup files, see
" https://github.com/neoclide/coc.nvim/issues/649
set nobackup
set nowritebackup

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" `Ctrl+Space` key press triggers completion
inoremap <silent><expr> <C-Space> coc#refresh()

" `Tab` key press calls `Ctrl+n` only if the completion window is visible
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" `Shift+Tab` key press calls `Ctrl+p` only if the completion window is
" visible
inoremap <expr> <S-TAB>
      \ pumvisible() ? "\<C-p>" :
      \ "\<C-h>"

" `Return` key press calls `Ctrl+y` only if completion window is visible.
" `<C-g>u` means break undo chain at current position.
if exists('*complete_info')
  inoremap <expr> <CR>
        \ complete_info()["selected"] != "-1" ? "\<C-y>" :
        \ "\<C-g>u\<CR>"
else
  imap <expr> <CR>
        \ pumvisible() ? "\<C-y>" :
        \ "\<C-g>u\<CR>"
endif

" Navigates to the previous diagnostic
nmap <silent> [g <Plug>(coc-diagnostic-prev)
" Navigates to the next diagnostic
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Goes to definition
nmap <silent> gd <Plug>(coc-definition)
" Goes to type definition
nmap <silent> gy <Plug>(coc-type-definition)
" Goes to implementation
nmap <silent> gi <Plug>(coc-implementation)
" Goes to references
nmap <silent> gr <Plug>(coc-references)

" Shows documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formats selected code
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" Apply `codeAction` to the selected region
" Example: `<leader>aap` for current paragraph
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)
" Remap keys for applying `codeAction` to the current line
nmap <leader>ac <Plug>(coc-codeaction)

" Apply AutoFix to problem on current line
nmap <leader>qf <Plug>(coc-fix-current)

" Show all diagnostics
nnoremap <silent> <Space>a :<C-u>CocList diagnostics<CR>
" Manage extensions
nnoremap <silent> <Space>e :<C-u>CocList extensions<CR>
" Show commands
nnoremap <silent> <Space>c :<C-u>CocList commands<CR>
" Find symbol in the current document
nnoremap <silent> <Space>o :<C-u>CocList outline<CR>
" Search workspace symbols
nnoremap <silent> <Space>s :<C-u>CocList -I symbols<CR>
" Do default action for next item
nnoremap <silent> <Space>j :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent> <Space>k :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <Space>p :<C-u>CocListResume<CR>

autocmd CursorHold * silent call CocActionAsync('highlight')

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Check the status of code completion
command! -nargs=0 -bar StatusCocCompletion :call vimrc#coc#StatusCocCompletion()
" Map leader sc to check the status of code completion
nmap <leader>sc :StatusCocCompletion<CR>
" Toggle code completion on and off
command! -nargs=0 -bar ToggleCocCompletion :call vimrc#coc#ToggleCocCompletion()
" Map leader tc to toggle code completion on and off
nmap <leader>tc :ToggleCocCompletion<CR>
