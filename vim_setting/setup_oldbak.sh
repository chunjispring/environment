#!/bin/bash

echo "安装将花费一定时间，请耐心等待直到安装完成^_^"
if which apt-get >/dev/null; then
    echo "You are using apt-get tool"
	sudo apt-get install -y vim vim-gnome ctags xclip astyle python-setuptools python-dev git
elif which yum >/dev/null; then
    echo "You are using yum tool"
	sudo yum install -y gcc vim git ctags xclip astyle python-setuptools python-devel	
elif which brew >/dev/null; then
    # echo "You are using HomeBrew tool"
    brew install vim ctags git astyle
fi

sudo easy_install -ZU autopep8 
sudo ln -s /usr/bin/ctags /usr/local/bin/ctags

#git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
#git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "正在努力为您安装bundle程序"
rm -rf ~/.vim*
cp -rf vim_setting ~/.vim
mv -f ~/.vim/vimrc2 ~/.vimrc
vim +PluginInstall +qall
echo "安装完成"

