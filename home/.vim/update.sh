#!/usr/bin/env sh

main() {
  exec vim \
    -c PlugUpgrade \
    -c PlugUpdate \
    -c "
      if exists('g:plugs[\"coc.nvim\"]')
        call vimrc#coc#ToggleCoc()
        call coc#util#update_extensions()
      endif
    " \
    -c qa
}

main "$@"
