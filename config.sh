#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

# vim.rc file
rm -f ${HOME}/.vimrc && ln -s $(pwd)/.vimrc ${HOME}/.vimrc
rm -f ${HOME}/.gvimrc && ln -s $(pwd)/.gvimrc ${HOME}/.gvimrc
# vim color theme
mkdir -p ${HOME}/.vim/colors
rm -f ${HOME}/.vim/colors/solarized.vim
ln -s $(pwd)/.vim/colors/solarized.vim ${HOME}/.vim/colors/solarized.vim

# tmux
rm -f ${HOME}/.tmux.conf && ln -s $(pwd)/.tmux.conf ${HOME}/.tmux.conf

# tmux colors
rm -drf ${HOME}/.tmux/colors
mkdir -p ${HOME}/.tmux
ln -s $(pwd)/.tmux/colors ${HOME}/.tmux/colors
# shell colors
rm -f ${HOME}/.dircolors.dark && ln -s $(pwd)/dircolors.256dark ${HOME}/.dircolors.dark
rm -f ${HOME}/.dircolors.light && ln -s $(pwd)/.dircolors.light ${HOME}/.dircolors.light

# zshrc file
rm -f ${HOME}/.zshrc && ln -s $(pwd)/.zshrc ${HOME}/.zshrc
if [[ $(uname) == "Linux" ]]; then
  # font configs
  mkdir -p ${HOME}/.config/fontconfig
  rm -f ${HOME}/.config/fontconfig/fonts.conf
  ln -s $(pwd)/fonts.conf ${HOME}/.config/fontconfig/fonts.conf
  # zathura configs
  mkdir -p ${HOME}/.config/zathura
  rm -f ${HOME}/.config/zathura/zathurarc
  ln -s $(pwd)/zathurarc ${HOME}/.config/zathura/zathurarc
fi

# zed settings
mkdir -p ${HOME}/.config/zed
if [[ -f ${HOME}/.config/zed/settings.json ]]; then
  rm -f ${HOME}/.config/zed/settings.json
fi
ln -s $(pwd)/zed/settings.json ${HOME}/.config/zed/settings.json

# ghostty settings
mkdir -p ${HOME}/.config/ghostty
if [[ -f ${HOME}/.config/ghostty/config ]]; then
  rm -f ${HOME}/.config/ghostty/config
fi
ln -s $(pwd)/ghostty/config ${HOME}/.config/ghostty/config
