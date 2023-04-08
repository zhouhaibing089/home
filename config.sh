#!/bin/bash

# vim.rc file
rm -f ${HOME}/.vimrc && ln -s $(pwd)/.vimrc ${HOME}/.vimrc
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
# zshrc file
rm -f ${HOME}/.zshrc && ln -s $(pwd)/.zshrc ${HOME}/.zshrc
