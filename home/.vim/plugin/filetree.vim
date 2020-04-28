if exists('g:did_vimrc_filetree_loaded')
  finish
endif
let g:did_vimrc_filetree_loaded = 1

" Close the tree window after opening a file
let g:NERDTreeQuitOnOpen = 1

function! VimrcCocAddKeybindingsFiletree()
  silent! unmap! <leader>d
  " Map `leader d` to use `coc-explorer`
  map <silent> <leader>d :CocCommand explorer --quit-on-open<CR>
endfunction

function! VimrcCocRemoveKeybindingsFiletree()
  silent! unmap! <leader>d
  " Map `leader d` to use `NERDTree`
  map <silent> <leader>d :NERDTreeToggle<cr>
endfunction

" Use the coc-explorer extension if available otherwise fall back to NERDTree
if exists('g:plugs["coc.nvim"]') && vimrc#coc#DetectExtension('coc-explorer')
  call vimrc#coc#RegisterStartCallback('VimrcCocAddKeybindingsFiletree')
  call vimrc#coc#RegisterStopCallback('VimrcCocRemoveKeybindingsFiletree')
endif

if vimrc#coc#IsRunning() && vimrc#coc#DetectExtension('coc-explorer')
  call VimrcCocAddKeybindingsFiletree()
else
  call VimrcCocRemoveKeybindingsFiletree()
endif
