#!/bin/bash

DOTFILE_DIR="$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)"
source "$DOTFILE_DIR/scripts/setup"

@clean
  - gc: true

@install Install Shell Config
  - .zshrc
  - .local/share/zsh/site-functions

@install Install Vim  Config
  - .vim

@install Install Miscellaneous Config
  - .tmux.conf

@packages
 - init: true

# The below will not run unless --nvm is specified
@nvm
 - install
