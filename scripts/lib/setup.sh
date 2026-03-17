#!/bin/bash

FORCE=0
VERBOSE=0
UNINSTALL=0

parse_options() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -f|--force)   FORCE=1 ;;
      -v|--verbose) VERBOSE=1 ;;
      uninstall)    UNINSTALL=1 ;;
      *) error_exit "Unknown option: $1" ;;
    esac
    shift
  done
}

link_file() {
  local name="$1"

  if [[ ! -e "${FILES_DIR}/${name}" ]]; then
    error_setup_skip "${name}" "Not in ${FILES_DIR}"
    return
  fi

  if [[ "${UNINSTALL}" -eq 1 ]]; then
    _unlink_file "${name}"
    return
  fi

  pushd ~ >/dev/null

  if [[ -e "${name}" && ! -L "${name}" && "${FORCE}" -eq 0 ]]; then
    error_setup_skip "${name}" "already exists (use --force to overwrite)"
    popd >/dev/null
    return
  fi

  [[ "${VERBOSE}" -eq 1 ]] && echo "  ${FILES_DIR}/${name} -> ~/${name}"

  if ! ln -fns "${FILES_DIR}/${name}" "${name}"; then
    error_setup_skip "${name}" "failed to link"
    popd >/dev/null
    return
  fi

  popd >/dev/null
  success_setup "${name}"
}

_unlink_file() {
  local name="$1"

  pushd ~ >/dev/null
  if [[ -L "${name}" ]]; then
    rm "${name}"
    success_setup "unlinked ${name}"
  else
    [[ "${VERBOSE}" -eq 1 ]] && echo "  skip: ~/${name} is not a symlink"
  fi
  popd >/dev/null
}

install_nvm() {
  local nvmdir="${FILES_DIR}/.nvm"
  pushd "$nvmdir" >/dev/null

  git fetch --tags origin
  git checkout --quiet \
    `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`

  source "$nvmdir/nvm.sh"

  if ! command -v nvm >/dev/null; then
    error_setup_skip "nvm" "failed to install"
    popd >/dev/null && return
  fi

  popd >/dev/null
  success_setup ".nvm"
}

install_vim_plug() {
  pushd ~ >/dev/null
  vim -es -u .vim/vimrc -i NONE -c "PlugInstall" -c "qa"
  popd >/dev/null
  success_setup "vim-plug"
}

error_exit() {
  printf '%s\n' "$1" >&2
  exit "${2:-1}"
}

success_setup() {
  echo "[$(tput -Tscreen-256color setaf 2)OK$(tput -Tscreen-256color sgr0)] $1"
}

error_setup_skip() {
  echo "[$(tput -Tscreen-256color setaf 1)NG$(tput -Tscreen-256color sgr0)] $1 ($2)"
}
