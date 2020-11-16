Plug 'chriskempson/base16-vim'
Plug 'markabe/bufexplorer'
Plug 'mileszs/ack.vim'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-git'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vividchalk'
Plug 'sheerun/vim-polyglot'
Plug 'rust-lang/rust.vim'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }

" Plugins that require specific, newer versions of vim
if v:version > 704
  Plug 'fatih/vim-go'
  Plug 'andymass/vim-matchup'
endif

" Plugins that require specific, newer versions of vim
if v:version > 800
  Plug 'euclio/vim-markdown-composer'
endif

" Use `coc.nvim` if Vim version support it and if `node` is installed
if v:version > 800 && executable('node')
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }
else
  let s:msg = 'Node not found on system or Vim is too old. '
  let s:msg .= 'Please ensure pre-requisites are met and re-launch Vim.'
  command! -nargs=0 -bar StatusCoc :call vimrc#ErrorMsg('coc.nvim', s:msg)
  nmap <leader>sc :StatusCoc<CR>
  command! -nargs=0 -bar ToggleCoc :call vimrc#ErrorMsg('coc.nvim', s:msg)
  nmap <leader>tc :ToggleCoc<CR>
endif

" Use `fzf` if Vim version supports it and if `fzf` is installed
if v:version >= 740 && executable('fzf')
  " The install script with `--bin` should detect the system installed program
  " and produce a symlink at `~/.vim/plugged/fzf/bin/fzf`
  Plug 'junegunn/fzf', { 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
else
  Plug 'ctrlpvim/ctrlp.vim'
endif

" Use `indentLine` unless we're on FreeBSD
if has('unix') && systemlist('uname -s')[0] !=? 'FreeBSD'
  Plug 'Yggdroot/indentLine'
endif
