#!/bin/bash

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)"
DOTFILES_LIB="${DOTFILES_ROOT}/scripts/lib/setup.sh"
FILES_DIR="${DOTFILES_ROOT}/files"

if [[ ! -f "${DOTFILES_LIB}" ]]; then
  printf '%s\n' "Error: ${DOTFILES_LIB} not found" >&2
  exit 1
fi

source "${DOTFILES_LIB}"

[[ -d "${FILES_DIR}" ]] || error_exit "No ${FILES_DIR}"

parse_options "$@"

if [[ "${UNINSTALL}" -eq 1 ]]; then
  echo "# Unlinking dotfiles..."
else
  echo "# Linking dotfiles..."
fi

# shell config
link_file .bashrc
link_file .zshenv
link_file .zshrc
link_file .zlogout
link_file .local/share/zsh/site-functions

# git config
link_file .config/git/config

# vim config
link_file .vim

# neovim config
link_file .config/nvim/init.lua
link_file .config/nvim/lua/plugins

# tmux config
link_file .tmux.conf

# nvm
link_file .nvm

if [[ "${UNINSTALL}" -ne 1 ]]; then
  echo "# Running install scripts..."
  install_nvm
  install_vim_plug
fi

echo "# dotfiles has been set up successfully."
