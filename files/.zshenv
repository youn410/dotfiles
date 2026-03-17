# read after /etc/zshenv.
# ref: https://zsh.sourceforge.io/Doc/Release/Files.html

# -U: For arrays, keep only the first occurrence of each duplicated value for shell parameters
# ref: http://zsh.sourceforge.net/Doc/Release/Shell-Builtin-Commands.html
typeset -U path manpath

# ignore /etc/zprofile, /etc/zshrc, /etc/zlogin, and /etc/zlogout
# ref. http://zsh.sourceforge.net/Doc/Release/Files.html
unsetopt GLOBAL_RCS
# copied from /etc/zprofile
# system-wide environment settings for zsh(1)
if [ -x /usr/libexec/path_helper ]; then
  eval `/usr/libexec/path_helper -s`
fi

path=(
  /usr/local/bin
  /usr/local/opt/coreutils/libexec/gnubin(N-/) # coreutils
  ${path}
)

manpath=(
  /usr/local/bin
  /usr/local/opt/coreutils/libexec/gnuman(N-/) # coreutils
  ${manpath}
)
