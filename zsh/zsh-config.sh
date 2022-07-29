#!/usr/bin/env bash
# Created by Wayne, 2022.7.29

PWD=$(readlink -f "$(dirname "$0")")

# 安装依赖包
yum install -y $PWD/rpm/zsh/*.rpm 2>&-
yum install -y $PWD/rpm/git/*.rpm 2>&-

# 安装oh-my-zsh
rm -rf ~/.oh-my-zsh 2>&-
curl -fsSL https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh -o /tmp/ohmyzsh.sh
sed -i 's#REPO=${REPO:-ohmyzsh/ohmyzsh}#REPO=${REPO:-mirrors/oh-my-zsh}#g' /tmp/ohmyzsh.sh
sed -i 's#REMOTE=${REMOTE:-https://github.com/${REPO}.git}#REMOTE=${REMOTE:-https://gitee.com//${REPO}.git}#g' /tmp/ohmyzsh.sh
sed -i '/exec zsh -l/d' /tmp/ohmyzsh.sh
sh -c "$(cat /tmp/ohmyzsh.sh)"

# 安装oh-my-zsh插件
cp -a $PWD/plugins/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins
cp -a $PWD/plugins/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins
sed -i 's/)$/ zsh-syntax-highlighting zsh-autosuggestions)/g' ~/.zshrc

# 切换至zsh
exec zsh -l