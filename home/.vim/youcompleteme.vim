" The YouCompleteMe plugin is...complicated. And massive. And not always
" required. Therefore, this code will not register and install the plugin
" unless explicitly asked for by a user. Additionally, the plugin will not be
" loaded unless explicitly asked for by a user once installed. In this way,
" systems that cannot run this plugin will not clone the repository (and
" massive submodule footprint), and will not attempt to run the
" post-installation which may require additional software to be installed.
"
" ## Installation
"
" To install the plugin, a command called `:YcmInstall` is registered which
" will register the plugin, perform the installation (i.e. the Git clone and
" submodule clones), and execute the `./install.py` post-installation program
" with flags computed by checking for language support locally installed.
"
" ## Loading
"
" Once installed, the plugin is left in an un-loaded state which means that
" the load time of Vim is not impacted, extra forked process won't consume CPU
" and RAM, etc. To load the plugin, a command called `:YcmLoad` is registered
" which will load the plugin into Vim and leave your session ready to go.

let g:ycm_name = 'YouCompleteMe'
let g:ycm_repo = 'Valloric/' . g:ycm_name

function! s:ycm_install()
  if !executable('cmake')
    echohl ErrorMsg
    echo '[' . g:ycm_name . ' install] ' .
          \ 'cmake not found which is required. Please install and retry.'
    echohl None
    return 1
  endif

  " Register the plugin
  call plug#(g:ycm_repo, { 'do': function('YcmPostinstall'), 'on': 'YcmLoad' })
  " Install the plugin and run the post-installation
  execute 'PlugInstall ' . g:ycm_name
endfunction

function! YcmPostinstall(info)
  " Determine the language support based on what is present on the system
  let flags = []
  if executable('clang')
    call add(flags, '--clang-completer')
  endif
  if executable('mono')
    call add(flags, '--cs-completer')
  endif
  if executable('go')
    call add(flags, '--go-completer')
  endif
  if executable('npm')
    call add(flags, '--js-completer')
  endif
  if executable('rustc')
    call add(flags, '--rust-completer')
  endif
  if !executable('tsserver')
    echohl WarningMsg
    echom '[' . g:ycm_name . ' install] ' .
          \ 'TypeScript not enabled, to add run: `npm install -g typescript`'
    echohl None
  endif

  " Run the install program with the computed flags
  execute "!./install.py " . join(flags)
  " Register the `:YcmLoad` command
  command! -nargs=0 -bar YcmLoad call s:ycm_load()
  " De-register the `:YcmInstall` command
  delcommand YcmInstall
  echom '[' . g:ycm_name . ' install] Installation complete, ' .
        \ 'to load now or in the future, run `:YcmLoad`.'
endfunction

function! s:ycm_load()
  " De-register the `:YcmLoad` command
  delcommand YcmLoad
  " Load the plugin
  call plug#load(g:ycm_name)
  echom 'Loaded ' . g:ycm_name . '.'
endfunction

" If the YouCompleteMe plugin directory exists, assume that it is setup and
" register (but don't load) the plugin.
if isdirectory(expand(g:plug_home . "/" . g:ycm_name))
  Plug g:ycm_repo, { 'on': 'YcmLoad' }

  " Register the `:YcmLoad` command to load the plugin for use only when
  " explicitly asked for
  command! -nargs=0 -bar YcmLoad call s:ycm_load()
else
  " If the plugin directory doesn't exist, then register the `:YcmInstall`
  " command which will only register and install (but not load) the plugin
  " when explicitly asked for
  command! -nargs=0 -bar YcmInstall call s:ycm_install()
endif
