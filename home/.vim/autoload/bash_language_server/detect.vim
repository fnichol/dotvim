function! bash_language_server#detect#Detect() abort
  let l:var = 'bash_langauage_server_installed'
  let l:buffer = bufnr('')

  if !vimrc#buffer#Exists(l:var)
    " Load language server linter
    silent! runtime! ale_linters/sh/language_server.vim

    let l:exec = ale_linters#sh#language_server#GetExecutable(l:buffer)
    let l:is_found = executable(l:exec)

    call vimrc#buffer#Set(l:buffer, l:var, l:is_found)

    if l:is_found
      let b:ale_sh_language_server_executable = l:exec
    endif
  end

  return vimrc#buffer#Var(l:buffer, l:var)
endfunction
