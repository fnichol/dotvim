function! vim_markdown_composer#detect#Detect() abort
  let l:var = 'vim_markdown_composer_installed'
  let l:buffer = bufnr('')

  if !vimrc#buffer#Exists(l:var)
    let g:vim_markdown_composer_installed = executable(
          \ fnameescape(g:plugs['vim-markdown-composer']['dir'])
          \ . 'target/release/markdown-composer')
  end

  return vimrc#buffer#Var(l:buffer, l:var)
endfunction
