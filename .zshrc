# whatever comes from the work setup, let it be imported first (so we can
# override later)
if [[ -f ${HOME}/.zshrc.work ]]; then
  source ${HOME}/.zshrc.work
fi

if [[ -d /opt/homebrew/bin ]]; then
  export PATH=/opt/homebrew/bin:${PATH}
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
export EDITOR=vim

plugins=(git)
if [[ $(uname) == "Linux" ]]; then
  eval $(dircolors ${HOME}/.dircolors.dark)
else
  eval $(gdircolors ${HOME}/.dircolors.dark)
fi

if [[ ${TMUX} ]]; then
  wname=$(tmux display-message -p -t "$TMUX_PANE" '#W')
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

PROMPT='%#'
type k &>/dev/null
if [ $? -eq 0 ]; then
  PROMPT='%F{blue}%B%U%#%u%b%f'
fi

ZSH_THEME_GIT_PROMPT_PREFIX=' %F{green}('
ZSH_THEME_GIT_PROMPT_SUFFIX=')%f'
PROMPT+=' %F{magenta}%~%f$(git_prompt_info) '
RPROMPT='[%D{%H:%M:%S}]'
ZLE_RPROMPT_INDENT=0

unsetopt share_history

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
