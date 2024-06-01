[ -r /etc/zshrc ] && . /etc/zshrc
[ -r /etc/zlogin ] && . /etc/zlogin

fpath+=(~/.local/share/zsh/site-functions)
autoload -Uz add-zsh-hook

# Alias
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ls='ls -F --color=auto'
alias ll='ls -lh'
alias la='ls -lAh'
alias tmuxat='tmux attach-session -t'
alias vimr='vim -R'

#=========#
# History #
#=========#
HISTFILE=~/.cache/zsh/history
HISTSIZE=10000
SAVEHIST=10000

# Save each command’s beginning timestamp and the duration to the history file
setopt extended_history
# Remove the oldest duplicated history event first when the limit of storage in history
setopt hist_expire_dups_first
# Do not enter command lines into the history list if they are duplicates of the previous event
setopt hist_ignore_dups
# Remove command lines from the history list when the first character on the line is a space
setopt hist_ignore_space
# Remove superfluous blanks from each command line being added to the history list
setopt hist_reduce_blanks
# both imports new commands from the history file, and causes typed commands to be appended to the history file
setopt share_history

#============#
# Completion #
#============#
zmodload -i zsh/complist

# The option EXTENDED_GLOB is set locally
() {
  # make different syntax for glob qualifiers available, namely ‘(#qx)’ 
  setopt localoptions extended_glob
  autoload -Uz compinit

  zstyle ':completion:*' menu select

  # update the completion cache only once a day
  # check cached .zcompdump file once a day to restrict delay to zsh startup
  # - '#q' is intended to support the use of glob qualifiers
  # - 'N' deletes the pattern instead of reporting an error when it doesn't match
  # - '.' matches plain files
  # - 'mh+24' matches files that are older than 24 hours
  # cf. https://zsh.sourceforge.io/Doc/Release/Expansion.html#Glob-Qualifiers
  if [[ -n ~/.cache/zsh/compdump(#qN.mh+24) ]]; then
    compinit -u -d ~/.cache/zsh/compdump && touch ~/.cache/zsh/compdump
  else
    compinit -C -d ~/.cache/zsh/compdump
  fi
}

# =============#
# Key Bindings #
# =============#
autoload -Uz mv-cursor-beginning-of-line && zle -N mv-cursor-beginning-of-line
autoload -Uz history-search-end \
  && zle -N history-beginning-search-backward-end history-search-end \
  && zle -N history-beginning-search-forward-end history-search-end
autoload -Uz fzf-cd-vcs-widget && zle -N fzf-cd-vcs-widget
autoload -Uz fzf-widgets \
  && zle -N fzf-menu-widget fzf-widgets \
  && zle -N fzf-git-branch-widget fzf-widgets \
  && zle -N fzf-history-widget fzf-widgets \
  && zle -N fzf-hostname-widget fzf-widgets \
  && zle -N fzf-tmux-session-widget fzf-widgets

bindkey -v
bindkey -v \
  '^A' mv-cursor-beginning-of-line \
  '^B' backward-char \
  '^F' forward-char \
  '^N' history-beginning-search-forward-end \
  '^P' history-beginning-search-backward-end \
  '^G^V' fzf-cd-vcs-widget \
  '^G^B' fzf-git-branch-widget \
  '^X^U' fzf-menu-widget \
  '^X^H' fzf-hostname-widget \
  '^X^L' fzf-history-widget \
  '^X^T' fzf-tmux-session-widget
bindkey -M menuselect \
  '^B' backward-char \
  '^F' forward-char

autoload -Uz promptinit && promptinit
prompt concise
unsetopt prompt_cr

unsetopt nomatch # Do not raise error when glob can not be expanded

###############
#  loads nvm  #
###############
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
