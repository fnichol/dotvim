CocExtension 'coc-css'
CocExtension 'coc-diagnostic'
CocExtension 'coc-eslint'
CocExtension 'coc-explorer'
CocExtension 'coc-go'
CocExtension 'coc-html'
CocExtension 'coc-json'
CocExtension 'coc-prettier'
CocExtension 'coc-rust-analyzer'
CocExtension 'coc-sh'
CocExtension 'coc-sql'
CocExtension 'coc-tailwindcss'
CocExtension 'coc-tsserver'
CocExtension 'coc-vetur'
CocExtension 'coc-vimlsp'
CocExtension 'coc-yaml'

" Use a PowerShell extention if `pwsh` is installed
if executable('pwsh')
  CocExtension 'coc-powershell'
endif
