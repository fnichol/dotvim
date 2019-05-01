function! bash_language_server#detect#Detect() abort
  if !exists('g:bash_language_server_installed')
    let g:bash_language_server_installed = executable('bash-language-server')
  end

  return g:bash_language_server_installed
endfunction
