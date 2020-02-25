function! prettier#detect#Detect() abort
  let l:var = 'prettier_installed'
  let l:buffer = bufnr('')

  if !vimrc#buffer#Exists(l:var)
    let l:exec = ale#fixers#prettier#GetExecutable(l:buffer)
    let l:is_found = executable(l:exec)

    call vimrc#buffer#Set(l:buffer, l:var, l:is_found)

    if l:is_found
      let b:ale_javascript_prettier_executable = l:exec
    endif
  end

  return vimrc#buffer#Var(l:buffer, l:var)
endfunction
