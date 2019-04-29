" Exit quickly when:
" - this plugin was already loaded (or disabled)
if exists('g:loaded_bash_language_server')
  finish
endif
let g:loaded_bash_language_server = 1

function! IsBashLanguageServerInstalled()
  if !exists('g:bash_language_server_installed')
    let g:bash_language_server_installed = executable('bash-language-server')
  end

  return g:bash_language_server_installed
endfunction
