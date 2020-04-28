" removes all vimrc autocommands to avoid autocmds appearing twice when vimrc
" is sourced twice
augroup vimrc
  autocmd!
augroup END

" vint: -ProhibitSetNoCompatible
set nocompatible                  " don't make vim vi-compatible (better)

set modelines=0                   " prevent possible exploits in modelines

" remap leader key to comma
let mapleader=','

set encoding=utf-8                " sets the character encoding used inside Vim
scriptencoding utf-8

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
set scrolloff=0                   " show 3 lines of context around the cursor

set title                         " set the terminal title

set cmdheight=2                   " give more space for displaying messages

set visualbell                    " no beeping

set nobackup                       " don't make backup before overwriting file
set nowritebackup                 " same again

set directory=$HOME/.vim/tmp//,.  " keep swap files in one location"

set tabstop=8                     " number of spaces that a <Tab> in the file
                                  " counts for
set shiftwidth=2                  " number of spaces to use for each step of
                                  " (auto)indent
set softtabstop=2                 " number of spaces that using <Tab> counts for
set expandtab                     " use spaces instead of tabs

set list                          " display unprintable characters

set updatetime=300                " longer update times leads to noticeable
                                  " delays and poor user experience
                                  " (used by coc.nvim)
set shortmess+=c                  " don't pass messages to ins-completion-menu
                                  " (used by coc.nvim)

" setting display chars for tab and eol
if (&encoding ==# 'utf-8' && &term isnot# 'linux')
  set listchars=tab:┆\ ,trail:-,extends:>,precedes:<,nbsp:+
else
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

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

" Preserve selection after indentation
vmap > >gv
vmap < <gv

" Map tab to indent in visual mode
vmap <Tab> >gv
vmap <S-Tab> <gv

set laststatus=2                  " always show status line

function! StatusLineCoc()
  let l:status = coc#status()
  return strlen(l:status) > 0 ? ' {' . l:status . '}' : ''
endfunction

" Set the status line info at bottom of screen
set statusline=
" Buffer number
set statusline+=[%n]
" Path to the file in the buffer
set statusline+=\ %<%.99f
" Buffer flags: help buffer, preview window, modified, read-only, file type
set statusline+=\ %h%w%m%r%y
" coc.nvim status, if installed and activated
set statusline+=%{exists('*coc#status')?StatusLineCoc():''}
set statusline+=\ %{get(b:,'coc_current_function','')}
" Separation point between left and right aligned items
set statusline+=%=
" Cursor location: line number, column number, virtual column number
set statusline+=%-16(\ %l,%c-%v\ %)
" Percentage through the file
set statusline+=%P

set background=dark               " blue on black background sucks

let s:theme = 'base16-twilight'   " Color scheme to set

" Set terminal type for which mouse codes are recognized when running under
" screen or tmux, or using the Alacritty terminal emulator
if &term =~? '^screen' || &term =~? '^tmux' || &term ==? 'alacritty'
  if has('mouse_sgr')
    " Prefer the newer `sgr` mouse handling, if supported by vim
    set ttymouse=sgr
  else
    " Otherwise fall back to `xterm2`
    set ttymouse=xterm2
  endif
endif

" Enable mouse support
set mouse=a

function! s:InstallPluginManager()
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

if has('user_commands') && v:version >= 700 && executable('git')
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
    echo 'Installing plugins...'
    echo ''
    :PlugInstall --sync | source $MYVIMRC
  endif
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has('gui_running')
  syntax enable                   " turn on syntax highlighting
  set hlsearch                    " highlights mactches
endif

if has('autocmd')
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
    if has('mac') && match(&term, '-256color$') != -1
      " Set the `t_8f` and `t_8b` options if running in tmux or screen
      if match(&term, '^screen-') != -1
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

" Assume that filtype=sh are posix and therefore will support proper `$(...)`
" syntax highlighting.
"
" See:
" * https://git.io/fjngy
" * https://github.com/tpope/vim-sensible/issues/140
let g:is_posix = 1

" The remaining configuration is for loaded plugins, so if the plugin manager
" isn't loaded, exit early
if !exists('g:plugs')
  finish
endif

" Insert the current date (i.e. `YYYY-MM-DD`) in insert and command modes
noremap! <leader>d <C-R>=strftime('%F')<CR>

" disable JSON syntax concealing
let g:vim_json_syntax_conceal = 0

" set a nicer indent line character, if possible
if (&encoding ==# 'utf-8' && &term isnot# 'linux')
  let g:indentLine_char = '┆'
endif

" close the tree window after opening a file
let g:NERDTreeQuitOnOpen = 1

" enable extended % matching for HTML, LaTeX, and many other languages
runtime macros/matchit.vim

if exists('g:plugs["fzf"]')
  " Map `Ctrl+p` to load a fuzzy file finder
  nnoremap <C-p> :Files<CR>
endif

if exists('g:plugs["ctrlp"]')
  " Ctrl-P ignores
  let g:ctrlp_custom_ignore = '\v[\/](tmp|vendor/bundle|\.git)$'

  " Ctrl-P sets its local working directory the directory of the current file
  let g:ctrlp_working_path_mode = 'a'
endif

if executable('rg')
  " Configure ack.vim to use ripgrep. Note that we're searching hidden
  " directories, but not inside `.git`
  let g:ackprg = 'rg --vimgrep --no-heading --smart-case '
  let g:ackprg .= "--no-ignore --hidden --follow -g '!.git/*'"

  " Set the grep program to use ripgrep
  " Thanks to: https://git.io/fjnOq
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\
        \ --no-ignore\ --hidden\ --follow\ -g\ '!.git/*'
endif

" Disable Markdown code folding
let g:vim_markdown_folding_disabled = 1
" Disable Markdown syntax concealing
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
" Highlight Markdown YAML front matter
let g:vim_markdown_frontmatter = 1
" Highlight Markdown TOML front matter
let g:vim_markdown_toml_frontmatter = 1

" Exclude `nerdtree` filetypes from indent behavior
let g:indentLine_fileTypeExclude = ['nerdtree']

" " vimwiki Configuration

" Setup the default 'brain' wiki
let brain_wiki = {}
" The path to the wiki files
let brain_wiki.path = '~/Documents/wikis/brain/content'
" Use Markdown syntax
let brain_wiki.syntax = 'markdown'
" Use `.md` as the wiki file extension
let brain_wiki.ext = '.md'
" Use dashes for spaces when creating a new file from a link
let brain_wiki.links_space_char = '-'
" Update the table of contents section when the current page is saved
let brain_wiki.auto_toc = 1
" Update the diary index when opened
let brain_wiki.auto_diary_index = 1
" Name of the wiki page to be used for the Diary index (found in `diary/`)
let brain_wiki.diary_index = 'index'
" Set list of files to be excluded when checking or generating links
let brain_wiki.exclude_files = ['**/README.md']

" Setup the public 'knowledge' wiki
let knowledge_wiki = deepcopy(brain_wiki)
" The path to the wiki files
let knowledge_wiki.path = '~/Documents/wikis/knowledge/content'

" Register the default wiki
let g:vimwiki_list = [brain_wiki, knowledge_wiki]
" Disable vimwiki mode for non-wiki markdown buffers
let g:vimwiki_global_ext = 0
" Generate a header when creating a new wiki page
let g:vimwiki_auto_header = 1
" Interpret a link of `dir/` as `dir/index.md`
let g:vimwiki_dir_link = 'index'
" Set auto-numbering in HTML, starting from header level 2
let g:vimwiki_html_header_numbering = 2
" Add a dot after the header's number
let g:vimwiki_html_header_numbering_sym = '.'
" The magic header name for a table of contents section
let g:vimwiki_toc_header = 'Table of Contents'
" Set the header level of the table of contents section to 2
let g:vimwiki_toc_header_level = 2
" Set the header level of the generated links section to 2
let g:vimwiki_links_header_level = 2
" Set the header level of the tags section to 2
let g:vimwiki_tags_header_level = 2

" Clear the background color in Termite or a 256 color term to get transparent
" background
if &term ==? 'xterm-termite' || match(&term, '-256color$') != -1
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
" - [[https://learnvimscriptthehardway.stevelosh.com/chapters/17.html]]
" - [[https://shapeshed.com/vim-statuslines/]]
