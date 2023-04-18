if [[ -d ${HOME}/go/bin && -z ${TMUX} ]]; then
  export GOROOT=${HOME}/go
  export PATH=${GOROOT}/bin:${PATH}
fi
if [[ -d ${HOME}/gopath && -z ${TMUX} ]]; then
  export GOPATH=${HOME}/gopath
  export PATH=${GOPATH}/bin:${PATH}
fi
if [[ -d ${HOME}/.cargo && -z ${TMUX} ]]; then
  export PATH=${HOME}/.cargo/bin:${PATH}
fi
if [[ -z ${TMUX} ]]; then
  export PATH=${HOME}/bin:${PATH}
fi

alias tmux='tmux -2'

if [[ ${TMUX} ]]; then
  wname=$(tmux display-message -p '#W')
  kubectl config get-contexts ${wname} &>/dev/null
  if [[ $? -eq 0 ]]; then
    function k() {
      kubectl "$@" --context=${wname}
    }
  fi
fi

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"
export SOLARIZED_THEME=dark

if [[ $(uname) == "Linux" ]]; then
  eval $(dircolors ${HOME}/.dircolors.dark)
else
  eval $(gdircolors ${HOME}/.dircolors.dark)
fi

ZSH_THEME="blinks"

if [[ $(uname) == "Linux" ]]; then
  plugins=(git golang kube-ps1)
else
  plugins=(git golang macos kube-ps1)
fi

source $ZSH/oh-my-zsh.sh

type k &>/dev/null
if [ $? -eq 0 ]; then
  echo "k is aliased"
else
  PROMPT=$PROMPT'$(kube_ps1) '
  RPROMPT='[%*]'
fi

unsetopt share_history
