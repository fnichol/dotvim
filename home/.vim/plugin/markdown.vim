if exists('g:did_vimrc_markdown_loaded') || !exists('g:plugs["vim-polyglot"]')
  finish
endif
let g:did_vimrc_markdown_loaded = 1

" Disable Markdown code folding
let g:vim_markdown_folding_disabled = 1
" Disable Markdown syntax concealing
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
" Highlight Markdown YAML front matter
let g:vim_markdown_frontmatter = 1
" Highlight Markdown TOML front matter
let g:vim_markdown_toml_frontmatter = 1
