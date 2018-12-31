" removes all vimrc autocommands to avoid autocmds appearing twice when vimrc
" is sourced twice
augroup vimrc
  autocmd!
augroup END

set nocompatible                  " don't make vim vi-compatible (better)

set modelines=0                   " prevent possible exploits in modelines

" remap leader key to comma
let mapleader=","

set encoding=utf-8                " sets the character encoding used inside Vim

set showcmd                       " display incomplete commands
set showmode                      " display your current mode

set backspace=indent,eol,start    " intuitive backspacing

set hidden                        " handle multiple buffers better

set wildmenu                      " enhanced command line completion
set wildmode=list:longest         " complete files like a shell

" use normal (perl-style) regext formatting
nnoremap / /\v
vnoremap / /\v
set ignorecase                    " case insensitive matching
set smartcase                     " turns case-sensitive if expression contains
                                  " a capital letter
set gdefault                      " :substitute flag 'g' is default on
set incsearch                     " highlight matching as you type

" clear out a search, remove highlighting
nnoremap <leader><space> :noh<cr>

set number                        " display line numbers
set ruler                         " show cursor position

set wrap                          " turn on line wrapping
set scrolloff=3                   " show 3 lines of context around the cursor

set title                         " set the terminal title

set visualbell                    " no beeping

set nobackup                       " don't make backup before overwriting file
set nowritebackup                 " same again

set directory=$HOME/.vim/tmp//,.  " keep swap files in one location"

set tabstop=2                     " number of spaces that a <Tab> in the file
                                  " counts for
set shiftwidth=2                  " number of spaces to use for each step of
                                  " (auto)indent
set softtabstop=2                 " number of spaces that using <Tab> counts for
set expandtab                     " use spaces instead of tabs

set list                          " display unprintable characters

" setting display chars for tab and eol
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

" ctrl+h: nav to left window
nnoremap <C-h> <C-w>h
" ctrl+j: nav to the window below
nnoremap <C-j> <C-w>j
" ctrl+k: nav to the window above
nnoremap <C-k> <C-w>k
" ctrl+l: nav to the right window
nnoremap <C-l> <C-w>l
" opens new vert split and switch over to it
map <leader>w <C-w>v<C-w>l

" map leader d to NERDTreeToggle (show/hide drawer)
map <leader>d :NERDTreeToggle<cr>

" Strip trailing whitespace on lines
map <leader>ws :%s/ *$//g<cr><c-o><cr>

" Format JSON, thanks to:
" http://blog.realnitro.be/2010/12/20/format-json-in-vim-using-pythons-jsontool-module/
nmap <leader>js :%!python -m json.tool<cr>:%s/ \{4\}/  /<cr>:noh<cr>gg

" Format XML
nmap <leader>xml :%!xmllint --format -<cr>

" Wrap selected lines to 75 char width
nmap <leader>wl :!fmt -w 75<cr>

" Replace insert pry breakpoint in insert mode
imap !!p require 'pry' ; binding.pry

" Preserve selection after indentation
vmap > >gv
vmap < <gv

" Map tab to indent in visual mode
vmap <Tab> >gv
vmap <S-Tab> <gv

set laststatus=2                  " always show status line
                                  " status line info at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

set background=dark               " blue on black background sucks

let s:theme = 'base16-twilight'   " Color scheme to set

function! s:InstallPluginManager()
  let plug_src = "https://github.com/junegunn/vim-plug.git"

  echo "Installing plugin manager..."
  echo ""
  let tmpdir = tempname()
  try
    silent !mkdir -p ~/.vim/autoload
    execute "silent !git clone --depth 1 " . plug_src . " " . tmpdir
    execute "silent !mv " . tmpdir . "/plug.vim ~/.vim/autoload/plug.vim"
  finally
    execute "silent !rm -rf " . tmpdir
  endtry
endfunction

if has("user_commands") && v:version >= 700 && executable('git')
  " Install plugin manager if not installed
  if filereadable(expand('~/.vim/autoload/plug.vim'))
    let s:initial_manager_install = 0
  else
    call s:InstallPluginManager()
    let s:initial_manager_install = 1
  endif

  " Load plugins
  call plug#begin()
  if filereadable(expand('~/.vim/plugins.vim'))
    source ~/.vim/plugins.vim
  endif
  call plug#end()

  " Install plugins if this is the initial installation
  if s:initial_manager_install == 1
    echo "Installing plugins..."
    echo ""
    :PlugInstall --sync | source $MYVIMRC
  endif
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax enable                   " turn on syntax highlighting
  set hlsearch                    " highlights mactches
endif

if has("autocmd")
  filetype plugin indent on       " turn on file type detection
  "
  " Restore cursor position
  autocmd vimrc BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif

if exists('g:plugs')
  " highlight extra whitespace
  autocmd vimrc ColorScheme * highlight ExtraWhitespace
        \ ctermbg=darkred guibg=#C75D5D
  " match trailing whitespace (except when typing)
  autocmd vimrc BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd vimrc InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd vimrc InsertLeave * match ExtraWhitespace /\s\+$/

  " If base16-shell is in use, then read colors from '~/.vimrc_background`
  " which has corrected colors for a 256-color theme variant
  if exists('$BASE16_THEME')
        \ && filereadable(expand('~/.base16_theme'))
        \ && filereadable(expand('~/.vimrc_background'))
    let base16colorspace=256
    source ~/.vimrc_background
  else
    if has('mac') && match(&term, "-256color$") != -1
      " Set the `t_8f` and `t_8b` options if running in tmux or screen
      if match(&term, "^screen-") != -1
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      endif
      " Set termguicolors if running on macOS in a 256 color term
      set termguicolors
    elseif !has('mac')
      " Set base16colorspace if not running on macOS
      let base16colorspace=256
    endif

    " Set color theme, can be found in colors or in a bundle
    execute 'colorscheme ' . s:theme
  endif
elseif v:version >= 600
      \ && filereadable(resolve(expand('~/.vim/colors/vividchalk.vim')))
  " plugin managers not supported here, so colorscheme is found with symlink
  " in colors/ to an installed theme
  colorscheme vividchalk            " set color theme
endif

" Spelling

" Toggle spellchecking on and off
function! ToggleSpellCheck()
  set spell!
  if &spell
    echo '[toggle] Spell check enabled (+)'
  else
    echo '[toggle] Spell check disabled (-)'
  endif
endfunction
" Map leader ts to toggle spell checking on and off
map <leader>ts :call ToggleSpellCheck()<CR>

" Check the status of spellchecking
function! StatusSpellCheck()
  if &spell
    echo '[status] Spell check enabled (+)'
  else
    echo '[status] Spell check disabled (-)'
  endif
endfunction
" Map leader ss to check the status of spell checking
map <leader>ss :call StatusSpellCheck()<CR>

" Set spellchecking languages to be used in priority order
set spelllang=en_us,en_ca

" Enable spell checking by default
set spell

" Customize the display of words not recognized by the spellchecker
highlight clear SpellBad
highlight SpellBad
      \ term=underline,italic cterm=underline,italic gui=underline,italic
" Customize the display of words that should be capitalized
highlight clear SpellCap
highlight SpellCap
      \ term=italic cterm=italic gui=italic
" Customize the display of words that are recognized by the spellchecker as
" rare (i.e. hardly ever used)
highlight clear SpellRare
highlight SpellRare
      \ term=underline,italic cterm=underline,italic gui=underline,italic
highlight clear SpellLocal
" Customize the display of words that are recognized by the spellchecker that
" are used in another region
highlight SpellLocal
      \ term=underline cterm=underline gui=underline

" The remaining configuration is for loaded plugins, so if the plugin manager
" isn't loaded, exit early
if !exists('g:plugs')
  finish
endif

" ALE linter configuration

" Map leader a to manually run ALE lint
map <leader>a :ALELint<CR>

" Disable all highlighting of warnings and errors
let g:ale_set_highlights = 0

" Disable all other automatic linting runs and rely on the manual linting
" exclusively instead
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0
let g:ale_lint_on_filtype_changed = 0

" Initialize the ALE fixers dictionary
let g:ale_fixers = {}
let g:ale_fix_on_save = 1

" If `shfmt` is present, register it as an ALE fixer, using Google-style
" formatting
if executable('shfmt')
  let g:ale_fixers['sh'] = ['shfmt']
  let g:ale_sh_shfmt_options = '-i 2 -ci -bn'
endif

" Toggle code completion on and off
function! ToggleALECompletion()
  if g:ale_completion_enabled
    call ale#completion#Disable()
    echo '[toggle] ALE completion disabled (-)'
  else
    call ale#completion#Enable()
    echo '[toggle] ALE completion enabled (+)'
  endif
endfunction
" Map leader tc to toggle code completion on and off
nmap <leader>tc :call ToggleALECompletion()<CR>

" Check the status of code completion
function! StatusALECompletion()
  if g:ale_completion_enabled
    echo '[status] ALE completion enabled (+)'
  else
    echo '[status] ALE completion disabled (-)'
  endif
endfunction
" Map leader sc to check the status of code completion
nmap <leader>sc :call StatusALECompletion()<CR>

" Toggle fix-on-save on and off
function! ToggleALEFixOnSave()
  if g:ale_fix_on_save
    let g:ale_fix_on_save = 0
    echo '[toggle] ALE fix-on-save disabled (-)'
  else
    let g:ale_fix_on_save = 1
    echo '[toggle] ALE fix-on-save enabled (+)'
  endif
endfunction
" Map leader tc to toggle fix-on-save on and off
nmap <leader>tf :call ToggleALEFixOnSave()<CR>

" Check the status of fix-on-save
function! StatusALEFixOnSave()
  if g:ale_fix_on_save
    echo '[status] ALE fix-on-save enabled (+)'
  else
    echo '[status] ALE fix-on-save disabled (-)'
  endif
endfunction
" Map leader sc to check the status of fix-on-save
nmap <leader>sf :call StatusALEFixOnSave()<CR>

" Map `Ctrl+i` to hover
map <C-i> :ALEHover<cr>
" Map `g] to go to definition
nnoremap g] :ALEGoToDefinition<cr>

" `Tab` key press calls `Ctrl+n` only if the completion window is visible
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" `Shift+Tab` key press calls `Ctrl+n` only if the completion window is
" visible
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" `Retrun` key press calls `Ctrl+y` only if the completion window is visible
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"

" Auto-close the preview window when completion is done
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif


" close the tree window after opening a file
let g:NERDTreeQuitOnOpen = 1

" enable extended % matching for HTML, LaTeX, and many other languages
runtime macros/matchit.vim

" Ctrl-P ignores
let g:ctrlp_custom_ignore = '\v[\/](tmp|vendor/bundle|\.git)$'

" Ctrl-P sets its local working directory the directory of the current file
let g:ctrlp_working_path_mode = 'a'

source ~/.vim/rust.vim
autocmd vimrc FileType rust call FileTypeRust()

" Enable a bit more syntax highlighting for Go code
let g:go_highlight_types = 1
let g:go_highlight_fields = 1

" Clear the background color in Termite or a 256 color term to get transparent
" background
if &term == "xterm-termite" || match(&term, "-256color$") != -1
  highlight Normal ctermbg=NONE
endif

"
" = References and Credits =
" - [[http://stevelosh.com/blog/2010/09/coming-home-to-vim/]]
" - [[http://vimcasts.org/episodes/tabs-and-spaces/]]
" - [[http://github.com/rson/dotfiles/blob/master/vim/vimrc]]]
" - [[http://vimcasts.org/episodes/running-vim-within-irb/]]
" - [[http://rsontech.net/articles/2010/10/12/20/vim-plugin-management]]
" - [[http://vim.wikia.com/wiki/Highlight_unwanted_spaces]]
" - [[https://github.com/booyaa/rustlangserver.github.io]]
" - [[https://github.com/leafgarland/vimfiles/blob/master/.vimrc]]
" - [[http://seenaburns.com/vim-setup-for-rust/]]

