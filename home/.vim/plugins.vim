Plug 'chriskempson/base16-vim'
Plug 'elzr/vim-json'
Plug 'markabe/bufexplorer'
Plug 'mileszs/ack.vim'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vividchalk'
Plug 'honza/dockerfile.vim'
Plug 'slim-template/vim-slim'
Plug 'kurayama/systemd-vim-syntax'
Plug 'PProvost/vim-ps1'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'uarun/vim-protobuf'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }

" Plugins that require specific, newer versions of vim
if v:version > 704
  Plug 'fatih/vim-go'
endif

" Plugins that require specific, newer versions of vim
if v:version > 800
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'euclio/vim-markdown-composer'
endif

" Use fzf if vim is new enough and `fzf` is installed
if v:version >= 740 && executable('fzf')
  " The install script with `--bin` should detect the system installed program
  " and produce a symlink at `~/.vim/plugged/fzf/bin/fzf`
  Plug 'junegunn/fzf', { 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
else
  Plug 'ctrlpvim/ctrlp.vim'
endif

if has('unix') && systemlist('uname -s')[0] !=? 'FreeBSD'
  " Use indentLine unless we're on FreeBSD
  Plug 'Yggdroot/indentLine'
endif
