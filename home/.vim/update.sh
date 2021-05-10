#!/usr/bin/env sh

main() {
  exec vim -c "call vimrc#UpdateThenQuit()"
}

main "$@"
