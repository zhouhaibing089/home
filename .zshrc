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
if [[ $(uname -s) == Linux ]]; then
  if [[ $(gsettings get org.gnome.desktop.interface color-scheme) == *default* ]]; then
    export SOLARIZED_THEME=light
  else
    export SOLARIZED_THEME=dark
  fi
else
  export SOLARIZED_THEME=dark
fi
export EDITOR=vim

if [[ ${ZED_TERM} != "true" ]]; then
  ZSH_THEME="blinks"
fi

if [[ $(uname) == "Linux" ]]; then
  plugins=(git golang kube-ps1)
else
  plugins=(git golang macos kube-ps1)
fi

if [[ $(uname) == "Linux" ]]; then
  if [[ $(gsettings get org.gnome.desktop.interface color-scheme) == *default* ]]; then
    eval $(dircolors ${HOME}/.dircolors.light)
  else
    eval $(dircolors ${HOME}/.dircolors.dark)
  fi
else
  eval $(gdircolors ${HOME}/.dircolors.dark)
fi

if [[ ${TMUX} ]]; then
  wname=$(tmux display-message -p '#W')
  kubectl config get-contexts ${wname} &>/dev/null
  if [[ $? -eq 0 ]]; then
    # additional steps like proxy and other aliases
    if [[ -f ${HOME}/bin/on_kube_context ]]; then
      source ${HOME}/bin/on_kube_context ${wname}
    fi
    function k() {
      # TODO: I'm pretty sure there is a better way to do this!
      KUBECTL_ARGS_1=()
      KUBECTL_ARGS_2=()
      KUBECTL_HAS_ARGS_2=false
      for p in ${@}; do
        if [[ $p == "--" && ${KUBECTL_ARGS_2} != true ]]; then
          KUBECTL_HAS_ARGS_2=true
          continue
        fi
        if [[ ${KUBECTL_HAS_ARGS_2} = true ]]; then
          KUBECTL_ARGS_2+=(${p})
        else
          KUBECTL_ARGS_1+=(${p})
        fi
      done
      if [[ ${KUBECTL_HAS_ARGS_2} = true ]]; then
        kubectl ${KUBECTL_ARGS_1} --context=${wname} -- ${KUBECTL_ARGS_2}
      else
        kubectl ${KUBECTL_ARGS_1} --context=${wname}
      fi
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
