#!/bin/sh

#环境变量
myrc=${HOME}/.zshrc

## 安装home-brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

## 安装wget
brew install wget

## 改变默认shell为zsh
chsh -s /bin/zsh

## 安装oh_my_zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

## 安装autojump
brew install autojump

#更新配置文件
cat >>${myrc} <<EOF

################################ wcj Begin #####################################
echo "**********************************"
echo "************I am wangcj***********"
echo "**********************************"
echo "          *   *     *   *         "
echo "         *     *   *     *        "
echo "        *        *        *       "
echo "        *                 *       "
echo "   >>>------I love you!------->   "
echo "         *               *        "
echo "          *             *         "
echo "            *          *          "
echo "              *      *            "
echo "                *  *              "
echo "                 *                "

##################################################
#   for aliases
##################################################
alias cls='clear'
alias ll='ls -l'
alias la='ls -a'
alias vi='vim'
alias sc='source ${myrc}'
alias javac='javac -J-Dfile.encoding=utf8'
alias grep='grep --color=auto'
alias mm='brew update && brew upgrade && brew cleanup'
alias tt='telnet towel.blinkenlights.nl'

alias -s html=mate   # 在命令行直接输入后缀为 html 的文件名，会在 TextMate 中打开
alias -s rb=mate     # 在命令行直接输入 ruby 文件，会在 TextMate 中打开
alias -s py=vi       # 在命令行直接输入 python 文件，会用 vim 中打开，以下类似
alias -s js=vi
alias -s c=vi
alias -s java=vi
alias -s txt=vi
alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf'

EOF

[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && . ~/.autojump/etc/profile.d/autojump.sh

## vim自动安装配置
#rm -rf ./vim_setting
#git clone https://github.com/chunjispring/vim_setting.git
#cd vim_setting
#./setup.sh

cd vim_config
./install.sh
