function! vimrc#vim_markdown_composer#detect#Detect() abort
  let l:var = 'vim_markdown_composer_installed'
  let l:buffer = bufnr('')

  if !vimrc#buffer#Exists(l:var)
    let l:is_found = executable(
          \ fnameescape(g:plugs['vim-markdown-composer']['dir'])
          \ . 'target/release/markdown-composer')

    call vimrc#buffer#Set(l:buffer, l:var, l:is_found)
  end

  return vimrc#buffer#Var(l:buffer, l:var)
endfunction
