#!/bin/bash

## 安装依赖软件
function aptCheck()
{
    sudo apt install -y $1 2>&1 | grep -q "E:*dpkg" && sduo rm -rf /var/lib/dpkg/info && mkdir -p /var/lib/dpkg/info && apt install -y $1
}

echo "安装将花费一定时间，请耐心等待直到安装完成^_^"
if which apt >/dev/null; then
    echo "You are using apt-get tool"
    sudo apt update
    plugins="gcc tree vim vim-gnome vim-scripts vim-doc ctags xclip astyle python-setuptools python-dev git "
    ## xclip:建立终端和剪切板之间的通道
    for x in $plugins
    do 
        aptCheck $x
    done
elif which yum >/dev/null; then
    echo "You are using yum tool"
    sudo yum install -y gcc vim git ctags xclip astyle python-setuptools python-devel
elif which brew >/dev/null;then
    ##Add HomeBrew support on  Mac OS
    echo "You are using HomeBrew tool"
    brew install vim ctags git astyle
fi

## python 代码格式化工具
sudo easy_install -ZU autopep8 
if [ ! -f /usr/local/bin/ctags ];then
    sudo ln -s /usr/bin/ctags /usr/local/bin/ctags
fi

## 备份
mv -f ~/.vim ~/.vim_old
mv -f ~/.vimrc ~/.vimrc_old

## 安装vim配置
mkdir -p ~/.vim/bundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
 
cp -rf ./codeComplete/ ~/.vim/codeComplete/
cp -rf ./doc/          ~/.vim/doc/
cp -rf ./dict/         ~/.vim/dict/
cp -rf ./colors/       ~/.vim/colors/
cp -rf ./syntax/       ~/.vim/syntax/
cp -f ./myconfig/vimrc ~/.vimrc

##fc-list 查看字体列表
sudo cp -f ./myconfig/VeraMono.ttf /usr/share/fonts/VeraMono.ttf
##颜色库
#sudo cp -f ./colors/solarized.vim /usr/share/vim/vim80/colors/solarized.vim

#cp -f ./myconfig/bashrc ~/.bashrc
#source ~/.bashrc

#git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
#vim ~/.vimrc -c "BundleInstall" -c "q" -c "q"

echo "正在努力为您安装bundle程序" > spring
echo "安装完毕将自动退出" >> spring
echo "请耐心等待" >> spring
vim spring -c "BundleInstall" -c "q" -c "q"
rm ./spring
echo "安装完成"

## 解决c cpp文件头多注释的问题
mv ~/.vim/bundle/c.vim/c-support/templates/c.comments.template  ~/.vim/bundle/c.vim/c-support/templates/c.comments.template_bak
grep comment ~/.vim/bundle/c.vim/c-support/templates/c.comments.template_bak > ~/.vim/bundle/c.vim/c-support/templates/c.comments.template
