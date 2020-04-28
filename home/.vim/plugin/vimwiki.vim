if exists('g:did_vimrc_vimwiki_loaded') || !exists('g:plugs["vimwiki"]')
  finish
endif
let g:did_vimrc_vimwiki_loaded = 1

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
