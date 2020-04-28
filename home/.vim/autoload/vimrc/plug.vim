function! vimrc#plug#Load() abort
  if has('user_commands') && v:version >= 700 && executable('git')
    " Install plugin manager if not installed
    if filereadable(expand('~/.vim/autoload/plug.vim'))
      let l:initial_install = 0
    else
      call s:install_plug()
      let l:initial_install = 1
    endif

    " Load plugins
    call plug#begin()
    if filereadable(expand('~/.vim/plugins.vim'))
      source ~/.vim/plugins.vim
    endif
    call plug#end()

    " Install plugins if this is the initial installation
    if l:initial_install == 1
      echo 'Installing plugins...'
      echo ''
      :PlugInstall --sync | source $MYVIMRC
    endif
  endif
endfunction

function! s:install_plug() abort
  let l:plug_src = 'https://github.com/junegunn/vim-plug.git'

  echo 'Installing plugin manager...'
  echo ''
  let l:tmpdir = tempname()
  try
    silent !mkdir -p ~/.vim/autoload
    execute 'silent !git clone --depth 1 ' . l:plug_src . ' ' . l:tmpdir
    execute 'silent !mv ' . l:tmpdir . '/plug.vim ~/.vim/autoload/plug.vim'
  finally
    execute 'silent !rm -rf ' . l:tmpdir
  endtry
endfunction
