#!/bin/bash

#环境变量
CONKYHOME=${HOME}/.conky
mystart=${CONKYHOME}/start_conky.desktop
autostart=${HOME}/.config/autostart
mod="s@CONKYHOME@$CONKYHOME@g"
mod2="s@/home/spring/.conky@$CONKYHOME@g"
ZSHRC=~/.zshrc

#更新系统 安装conky cowsay fortune sl openssh-server zsh
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y conky-all cowsay fortune fortune-zh sl nmon htop openssh-server zsh

#改变默认shell为zsh
chsh -s /bin/zsh

#安装oh_my_zsh
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

#备份系统配置
myshell=${SHELL##*\/}
if [ "${myshell}" = "bash" ]
then
    myrc=${HOME}/.bashrc
    myrcbak=${HOME}/.bashrc_wcj
elif [ "${myshell}" = "zsh" ]
then
    myrc=${HOME}/.zshrc
    myrcbak=${HOME}/.zshrc_wcj
else
    echo "unsupport shell...${myshell}"
    exit 1
fi

if [ -f ${myrcbak} ]
then
    cp -p ${myrcbak} ${myrc}
else
    cp -p ${myrc} ${myrcbak}
fi

#更新配置文件
echo "" >> ${ZSHRC}
echo "######################### wcj Begin ##############################" >> ${ZSHRC}
#echo "fortune |cowsay" >> ${ZSHRC}
echo "fortune-zh |cowsay" >> ${ZSHRC}
echo "echo \"#########################################################\"" >> ${ZSHRC}
echo "echo \"###################### Hello World ######################\"" >> ${ZSHRC}
echo "echo \"#########################################################\"" >> ${ZSHRC}
echo "#echo \"\"" >> ${ZSHRC}
echo "#echo \"**********************************\"" >> ${ZSHRC}
echo "#echo \"************I am wangcj***********\"" >> ${ZSHRC}
echo "#echo \"**********************************\"" >> ${ZSHRC}
echo "#echo \"          *   *     *   *         \"" >> ${ZSHRC}
echo "#echo \"         *     *   *     *        \"" >> ${ZSHRC}
echo "#echo \"        *        *        *       \"" >> ${ZSHRC}
echo "#echo \"        *                 *       \"" >> ${ZSHRC}
echo "#echo \"   >>>------I love you!------->   \"" >> ${ZSHRC}
echo "#echo \"         *               *        \"" >> ${ZSHRC}
echo "#echo \"          *             *         \"" >> ${ZSHRC}
echo "#echo \"            *          *          \"" >> ${ZSHRC}
echo "#echo \"              *      *            \"" >> ${ZSHRC}
echo "#echo \"                *  *              \"" >> ${ZSHRC}
echo "#echo \"                                  \"" >> ${ZSHRC}
echo "" >> ${ZSHRC}
echo "##########################################" >> ${ZSHRC}
echo "#   for aliases" >> ${ZSHRC}
echo "##########################################" >> ${ZSHRC}
echo "alias h='history'" >> ${ZSHRC}
echo "alias sc='source ${ZSHRC}'" >> ${ZSHRC}
echo "alias c='clear'" >> ${ZSHRC}
echo "alias ll='ls -lrt'" >> ${ZSHRC}
echo "alias la='ls -AlF'" >> ${ZSHRC}
echo "alias l='ls -l'" >> ${ZSHRC}
echo "alias up='sudo apt-get update && sudo apt-get dist-upgrade -y'" >> ${ZSHRC}
echo "alias sk='dpkg --get-selections |grep linux'" >> ${ZSHRC}
echo "" >> ${ZSHRC}
echo "rk(){" >> ${ZSHRC}
echo "dpkg -l 'linux-*' | sed '/^ii/!d;/'\"\$(uname -r | sed \"s/\(.*\)-\([^0-9]\+\)/\1/\")\"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge" >> ${ZSHRC}
echo "}" >> ${ZSHRC}
echo "" >> ${ZSHRC}
echo "########################## wcj End ###############################" >> ${ZSHRC}
echo "" >> ${ZSHRC}

#配置conky
if [ -d ${CONKYHOME} ]
then
    rm -rf ${CONKYHOME}
fi

mkdir -p ${CONKYHOME}
cp -rf ./conkys/images ${CONKYHOME}
cp -rf ./conkys/scripts ${CONKYHOME}
cp ./conkys/conkyrc ${CONKYHOME}
cp ./conkys/start_conky.desktop ${CONKYHOME}
cp ./conkys/start_conky ${CONKYHOME}

#路径替换
#sed -i 's@robbyrussell@candy@g' ${myrc}
sed -i ${mod} ${mystart}
find ${CONKYHOME} -name "blinkingLED" -exec sed -i ${mod2} {} \;
find ${CONKYHOME} -name "conkyrc" -exec sed -i ${mod2} {} \;

#写开机启动 用gnome-session-properties会更好，原因在于可消除ssh远程登陆影响
if [ ! -d ${autostart} ]
then
    mkdir -p ${autostart}
fi
mv ${mystart} ${autostart}

#安装配置vim
git clone https://github.com/chunjispring/vim_setting
cd vim_setting
./setup.sh
