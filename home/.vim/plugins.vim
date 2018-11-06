Plug 'chriskempson/base16-vim'
Plug 'elzr/vim-json'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'markabe/bufexplorer'
Plug 'mileszs/ack.vim'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-markdown'
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
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'uarun/vim-protobuf'
Plug 'w0rp/ale'

" Plugins that require specific, newer versions of vim
if v:version > 704
  Plug 'fatih/vim-go'
endif

" Generic Language Server Protocol (LSP) support
if v:version > 800
  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
endif

" Lazily install & load the YouCompleteMe plugin
source ~/.vim/youcompleteme.vim
