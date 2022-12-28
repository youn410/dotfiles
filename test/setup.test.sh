echo "===== Test setup.sh ====="

no_scripts_utils() {
  echo "# No scripts/utils"
  rm scripts/utils

  ./setup.sh
  [[ $? == 1 ]] || exit 1

  git restore scripts
}

no_home() {
  echo "# No home/"
  rm -r home

  ./setup.sh
  [[ $? == 1 ]] || exit 1

  git restore home
}

no_conf() {
  echo "# No conf/"
  rm -r conf

  ./setup.sh
  [[ $? == 1 ]] || exit 1

  git restore conf
}

no_conf_dotfile_list() {
  echo "# No conf/dotfile_list"
  rm conf/dotfile_list

  ./setup.sh
  [[ $? == 1 ]] || exit 1

  git restore conf
}

no_scripts_utils
no_home
no_conf
no_conf_dotfile_list
