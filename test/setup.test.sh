echo "===== TEST setup.sh ====="

no_lib() {
  echo "[TEST] No scripts/lib/setup.sh"
  rm scripts/lib/setup.sh

  ./setup.sh
  [[ $? == 1 ]] || exit 1

  git restore scripts
}

no_files() {
  echo "[TEST] No files/"
  rm -r files

  ./setup.sh
  [[ $? == 1 ]] || exit 1

  git restore files
}

fail_in_link_file() {
  echo '[TEST] Fail in link_file (not in files/)'
  ./setup.sh
  # .not_in_files is not in files/, so link_file should show NG but not exit 1
}

uninstall_removes_links() {
  echo '[TEST] uninstall removes symlinks'
  ./setup.sh
  ./setup.sh uninstall
}

no_lib
no_files
fail_in_link_file
uninstall_removes_links
