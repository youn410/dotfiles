# in ~/.zshenv, executed `unsetopt GLOBAL_RCS`
# and ignored /etc/zshrc, /etc/zlogin
[ -r /etc/zshrc ] && . /etc/zshrc
[ -r /etc/zlogin ] && . /etc/zlogin

fpath+=(~/.local/share/zsh/site-functions)
autoload -Uz add-zsh-hook

###########################
#  Aliases and Functions  #
###########################
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls -F --color=auto'
alias ll='ls -lh'
alias la='ls -lAh'

autoload -Uz promptinit && promptinit
prompt concise

###############
#  loads nvm  #
###############
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
