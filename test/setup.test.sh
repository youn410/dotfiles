echo "===== TEST setup.sh ====="

no_scripts_utils() {
  echo "[TEST] No scripts/utils"
  rm scripts/utils

  ./setup.sh
  [[ $? == 1 ]] || exit 1

  git restore scripts
}

no_home() {
  echo "[TEST] No home/"
  rm -r home

  ./setup.sh
  [[ $? == 1 ]] || exit 1

  git restore home
}

no_conf() {
  echo "[TEST] No conf/"
  rm -r conf

  ./setup.sh
  [[ $? == 1 ]] || exit 1

  git restore conf
}

no_conf_dotfile_list() {
  echo "[TEST] No conf/dotfile_list"
  rm conf/dotfile_list

  ./setup.sh
  [[ $? == 1 ]] || exit 1

  git restore conf
}

fail_in_link_file() {
  echo '[TEST] Fail in link_file'
  cat << EOF > ./conf/dotfile_list
.bashrc
.not_in_home
EOF

  ./setup.sh

  git restore conf
}

no_scripts_utils
no_home
no_conf
no_conf_dotfile_list
fail_in_link_file
