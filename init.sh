#!/bin/bash

# archlinuxcn 源
function archlinuxcn() {
    echo '[archlinuxcn]
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
' | sudo tee -a /etc/pacman.conf
    sudo pacman -Sy archlinuxcn-keyring haveged
    sudo systemctl enable haveged
    sudo systemctl start haveged
    sudo pacman-key --init
    sudo pacman-key --populate manjaro
    sudo pacman-key --populate archlinux
    sudo pacman-key --populate archlinuxcn
}

# 上网
function ladder() {
    sudo pacman -Sy v2ray v2raya
    sudo systemctl enable --now v2raya.service
}

# 输入法
function inputMethod() {
    sudo pacman -S fcitx-rime
    sudo pacman -S fcitx-im
    sudo pacman -S fcitx-configtool
    echo 'export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
' | sudo tee -a ~/.xprofile

    # 配置 rime
    mv ~/.config/fcitx/rime ~/.config/fcitx/rime.bak
    git clone https://gitclone.com/github.com/hou8/rime.git ~/.config/fcitx/rime
}

# 主函数
function _main() {
    # 换源
    sudo pacman-mirrors -i -c China -m rank

    # 更新全部应用
    sudo pacman -Syyu

    # 另一个包管理工具
    sudo pacman -Sy yay

    # 一些最基本需要安装的包
    sudo pacman -Sy \
        git \
        vim \
        tldr \
        tree 

    # 一系列应用安装与配置
    archlinuxcn
    ladder
    inputMethod

    echo "done!"
}

# 入口
_main

