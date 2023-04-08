# If you come from bash you might have to change your $PATH.
export GOPATH=${HOME}/gopath
export GOROOT=${HOME}/go
export PATH=$HOME/bin:${GOROOT}/bin:${GOPATH}/bin:${HOME}/.cargo/bin:/usr/local/bin:$PATH

alias tmux='tmux -2'

if [[ ${TMUX} ]]; then
  wname=$(tmux display-message -p '#W')
  kubectl config get-contexts ${wname} &> /dev/null
  if [ $? -eq 0 ]; then
    # alias k="kubectl --context=${wname}"
    function k() { kubectl "$@" --context=${wname} }
    alias t="tess --context=${wname}"
    alias tmctl="tmctl --context=${wname}"
  fi
fi

# Path to your oh-my-zsh installation.
export ZSH="/Users/haibzhou/.oh-my-zsh"
export SOLARIZED_THEME=dark

eval $(gdircolors ${HOME}/.dircolors.dark)

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="blinks"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git golang macos kube-ps1)

source $ZSH/oh-my-zsh.sh

type k &> /dev/null
if [ $? -eq 0 ]; then
  echo "k is aliased"
else
  PROMPT=$PROMPT'$(kube_ps1) '
  RPROMPT='[%*]'
fi

# TMOUT=1
# TRAPALRM() {
#   zle reset-prompt
# }

unsetopt share_history
