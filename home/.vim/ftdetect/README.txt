Any files in ~/.vim/ftdetect/ will also be run every time you start Vim.

ftdetect stands for "filetype detection". The files in this directory should
set up autocommands that detect and set the filetype of files, and nothing
else. This means they should never be more than one or two lines long.
