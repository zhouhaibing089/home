#!/bin/bash

rm -f ${HOME}/.vimrc && ln -s $(pwd)/.vimrc ${HOME}/.vimrc
rm -f ${HOME}/.vim && ln -s $(pwd)/.vim ${HOME}/.vim
rm -f ${HOME}/.tmux.conf && ln -s $(pwd)/.tmux.conf ${HOME}/.tmux.conf
rm -f ${HOME}/.tmux && ln -s $(pwd)/.tmux ${HOME}/.tmux
rm -f ${HOME}/.dircolors.dark && ln -s $(pwd)/dircolors.256dark ${HOME}/.dircolors.dark
rm -f ${HOME}/.zshrc && ln -s $(pwd)/.zshrc ${HOME}/.zshrc
