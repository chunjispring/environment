 #!/bin/bash

#本地变量设置
ZSHRC=~/.zshrc
CONKYHOME=${HOME}/.conky
NET=`/sbin/ip addr |grep -w inet|awk '/dynamic/{print $8}'`
mystart=${CONKYHOME}/start_conky.desktop
autostart=${HOME}/.config/autostart
myrc=${HOME}/.zshrc
myrcbak=${HOME}/.zshrc_wcj

#替换  MYCONKY 替换为 真实路径   MYNET 替换为 真实网卡
mod="s@MYCONKY@$CONKYHOME@g"

#更新系统 安装常用软件
sudo apt update && sudo apt upgrade -y
sudo apt install -y conky-all cowsay fortune-mod fortunes-zh sl nmon htop openssh-server zsh valgrind locate screenfetch curl cppcheck

#改变默认shell为zsh
chsh -s `which zsh`

#安装oh_my_zsh
wget https://github.com/ohmyzsh/ohmyzsh/blob/master/tools/install.sh -O - | sh

#备份系统配置
cp -p ${HOME}/.bashrc ${HOME}/.bashrc_wcj

if [ -f ${myrcbak} ]
then
    cp -p ${myrcbak} ${myrc}
else
    cp -p ${myrc} ${myrcbak}
fi

#更新zshrc配置文件
cat >> ${ZSHRC} <<EOF

################################ wcj Begin #####################################
#fortune |cowsay
fortune-zh |cowsay
screenfetch
#curl wttr.in/shanghai

#echo "############################################################"
#echo "######################## Hello World #######################"
#echo "############################################################"
#echo "############################################################"
#echo ""
#echo "**********************************"
#echo "************I am wangcj***********"
#echo "**********************************"
#echo "          *   *     *   *         "
#echo "         *     *   *     *        "
#echo "        *        *        *       "
#echo "        *                 *       "
#echo "   >>>------I love you!------->   "
#echo "         *               *        "
#echo "          *             *         "
#echo "            *          *          "
#echo "              *      *            "
#echo "                *  *              "
#echo "                                  "

##################################################
#   for aliases
##################################################
alias h='history'
alias c='clear'
alias l='ls -l'
alias ll='ls -lrt'
alias la='ls -AlF'
alias n='netstat -antp'
alias v='valgrind --leak-check=full --tool=memcheck'
alias ck='cppcheck --enable=warning -I ~/mywork/include'
alias ckp='cppcheck --enable=warning --std=posix -I ~/mywork/include'
alias ckall='cppcheck --enable=all --inconclusive --std=posix -I ~/mywork/include *.c'

alias i='sudo apt install'
alias r='sudo apt purge'
alias u='sudo apt update'
alias p='sudo apt -y purge'
alias di='sudo dpkg -i'
alias sc='source ${ZSHRC}'
# check linux kernels on the system
alias sk='dpkg --get-selections |grep linux-\[him\]'
# remove linux kernels (warnning:This funtion can destory the system when just have one kernel on it)
alias sr='sudo apt -y purge '

alias mk='make'
alias up='sudo apt update && sudo apt dist-upgrade -y'
alias cls='sudo apt autoclean && sudo apt clean && sudo apt autoremove'

##################################################
#   for funtions
##################################################

################################# wcj End ######################################

. ~/mywork/etc/my.env

EOF

#配置conky
if [ -d ${CONKYHOME} ]
then
    rm -rf ${CONKYHOME}
fi

mkdir -p ${CONKYHOME}
cp -rf ./conkys/images ${CONKYHOME}
cp -rf ./conkys/scripts ${CONKYHOME}
cp ./conkys/conkyrc_bak ${CONKYHOME}
cp ./conkys/start_conky.desktop ${CONKYHOME}
cp ./conkys/start_conky ${CONKYHOME}

#路径替换
#sed -i 's@robbyrussell@candy@g' ${myrc}
sed -i ${mod} ${mystart}
find ${CONKYHOME} -name "blinkingLED" -exec sed -i ${mod} {} \;
find ${CONKYHOME} -name "conkyrc_bak" -exec sed -i ${mod} {} \;

#写开机启动 用gnome-session-properties会更好，原因在于可消除ssh远程登陆影响
if [ ! -d ${autostart} ]
then
    mkdir -p ${autostart}
fi
#conky有内存泄露的问题，暂不使用
#mv ${mystart} ${autostart}

#安装配置vim
#rm -rf ./vim_setting
#git clone https://github.com/chunjispring/vim_setting.git
#cd vim_setting
#./setup.sh

cd vim_config
./install.sh

