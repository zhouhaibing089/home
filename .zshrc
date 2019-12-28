# If you come from bash you might have to change your $PATH.
export GOPATH=${HOME}/gopath
export PATH=$HOME/bin:${GOPATH}/bin:${HOME}/.cargo/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/zhb/.oh-my-zsh"

eval $(gdircolors ${HOME}/dircolors.256dark)

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
plugins=(git golang osx)

source $ZSH/oh-my-zsh.sh
