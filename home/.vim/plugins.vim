" 2019-02-19 - Temporarily use fork of base16-vim which fixes an issue with
" Vim 8.1.0887 and newer. When a change is landed, then revert back to
" canonical repo.
"
" Issue https://github.com/chriskempson/base16-vim/issues/197
" Pull Request https://github.com/chriskempson/base16-vim/pull/198
Plug 'danielwe/base16-vim'
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
Plug 'pangloss/vim-javascript'
Plug 'Yggdroot/indentLine'

" Plugins that require specific, newer versions of vim
if v:version > 704
  Plug 'fatih/vim-go'
endif

" Plugins that require specific, newer versions of vim
if v:version > 800
  " 2019-04-18 - Temporarily use fork of ale which adds support for not
  " changing directories when using `shellcheck`. When a change is landed,
  " then revert back to canonical repo
  "
  " Pull Request https://github.com/w0rp/ale/pull/2446
  Plug 'fnichol/ale', { 'branch': 'add-var-sh-shellcheck-change-directory' }
endif

" Lazily install & load the YouCompleteMe plugin
source ~/.vim/youcompleteme.vim
