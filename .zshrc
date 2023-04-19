# whatever comes from the work setup, let it be imported first (so we can
# override later)
if [[ ! ${TMUX} && -f ${HOME}/.zshrc.work ]]; then
  source ${HOME}/.zshrc.work
fi

if [[ -d ${HOME}/go/bin ]]; then
  if [[ -f ${HOME}/go/bin/go ]]; then
    # Go installed manually
    export GOROOT=${HOME}/go
  else
    export GOPATH=${HOME}/go
  fi
  if [[ ! ${PATH} =~ ".*${HOME}/go/bin.*" ]]; then
    export PATH=${HOME}/go/bin:${PATH}
  fi
fi
if [[ -d ${HOME}/gopath ]]; then
  export GOPATH=${HOME}/gopath
fi
if [[ -n ${GOPATH} && ! ${PATH} =~ ".*${GOPATH}/bin.*" ]]; then
  export PATH=${GOPATH}/bin:${PATH}
fi
if [[ -d ${HOME}/.cargo && ! ${PATH} =~ ".*${HOME}/.cargo/bin.*" ]]; then
  export PATH=${HOME}/.cargo/bin:${PATH}
fi
if [[ ! ${PATH} =~ ".*${HOME}/bin.*" ]]; then
  export PATH=${HOME}/bin:${PATH}
fi

alias tmux='tmux -2'

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"
export SOLARIZED_THEME=dark

ZSH_THEME="blinks"

if [[ $(uname) == "Linux" ]]; then
  plugins=(git golang kube-ps1)
else
  plugins=(git golang macos kube-ps1)
fi

if [[ $(uname) == "Linux" ]]; then
  eval $(dircolors ${HOME}/.dircolors.dark)
else
  eval $(gdircolors ${HOME}/.dircolors.dark)
fi

if [[ ${TMUX} ]]; then
  wname=$(tmux display-message -p '#W')
  kubectl config get-contexts ${wname} &>/dev/null
  if [[ $? -eq 0 ]]; then
    function k() {
      kubectl "$@" --context=${wname}
    }
  fi
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
