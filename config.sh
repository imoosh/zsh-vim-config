#!/usr/bin/env bash
# Create by Wayne, 2022.7.29

PWD=$(readlink -f "$(dirname "$0")")

# 配置vim
bash $PWD/vim/vim-config.sh

# 配置zsh
bash $PWD/zsh/zsh-config.sh
