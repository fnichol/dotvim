#!/usr/bin/env sh

main() {
  exec vim -c "call vimrc#UpdateSync()" -c qa
}

main "$@"
