#!/bin/bash

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)"
UTILS_SCRIPT="${DOTFILES_ROOT}/scripts/utils"
HOME_DIR="${DOTFILES_ROOT}/home"
CONF_DIR="${DOTFILES_ROOT}/conf"

[[ -f "${UTILS_SCRIPT}" ]] || (printf '%s\n' "No ${UTILS_SCRIPT}" && false) || exit 1

source "${UTILS_SCRIPT}"
[[ -d "${HOME_DIR}" ]] || error_exit "No ${HOME_DIR}"
[[ -d "${CONF_DIR}" ]] || error_exit "No ${CONF_DIR}"

echo "# Link dotfiles..."
[[ -f "${CONF_DIR}/dotfile_list" ]] || error_exit "No ${CONF_DIR}/dotfile_list"
while read dotfile_name
do
  link_file "${dotfile_name}"
done < "${CONF_DIR}/dotfile_list"

echo "# Run install scripts..."
install_nvm
install_vim_plug

echo "# dotfiles has been set up successfuly."
