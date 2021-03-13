# If you come from bash you might have to change your $PATH.
export GOPATH=${HOME}/gopath
export GOROOT=${HOME}/go
export GOPRIVATE=*.corp.ebay.com,tess.io,golibs.tess.io
export PATH=$HOME/bin:${GOROOT}/bin:${GOPATH}/bin:${HOME}/.cargo/bin:/usr/local/bin:$PATH

source ${HOME}/rc/default

alias oops='mp-ssh ops-1687998.stratus.slc.ebay.com'
alias tmux='tmux -2'
alias modgo="GO111MODULE=on go"
alias fkubectl="KUBECONFIG=${HOME}/.kube/config-fcp-dev kubectl"
alias kkubectl="KUBECONFIG=${HOME}/.kube/config-kind kubectl"
alias k33="kubectl --context=33"
alias k32="kubectl --context=32"
alias k31="kubectl --context=31"
alias k51="kubectl --context=51"
alias k75="kubectl --context=75"
alias k77="kubectl --context=77"
alias k53="kubectl --context=53"

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
plugins=(git golang osx kube-ps1)

source $ZSH/oh-my-zsh.sh
PROMPT=$PROMPT'$(kube_ps1) '
RPROMPT='[%*]'

# TMOUT=1
# TRAPALRM() {
#   zle reset-prompt
# }

unsetopt share_history
