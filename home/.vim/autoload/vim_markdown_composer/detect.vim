function! vim_markdown_composer#detect#Detect() abort
  if !exists('g:vim_markdown_composer_installed')
    let g:vim_markdown_composer_installed = executable(
          \ fnameescape(g:plugs['vim-markdown-composer']['dir'])
          \ . 'target/release/markdown-composer')
  end

  return g:vim_markdown_composer_installed
endfunction
