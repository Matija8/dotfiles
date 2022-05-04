#!/usr/bin/env bash
# coding: UTF-8
# Bash script that installs packages for Kubuntu.

# Colors:
RED='\033[0;31m'
GREEN='\033[0;32m'
LGREEN='\033[1;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

# Retry this script as root.
# ((EUID != 0)) && exec sudo -- "$0" "$@"

# Set current working directory to this scripts directory.
cd "$(dirname "$0")"

function main {
    trap "exit" INT
    printf "${PURPLE}Starting package installation...${NC}\n"
    sudo printf "${PURPLE}Sudo mode success\n\n"

    # Add single installation function here to test it
    # and uncomment the `exit` below
    # install_XXX
    # exit

    sudo apt update
    sudo apt upgrade -y

    install_APT_packages
    install_snaps
    install_vscode

    install_python
    install_js

    # install_java
    # install_rust
    # install_go_lang

    # install_docker
    # install_docker_compose

    wrap_up_installing
    printf "\n\n${PURPLE}All Done!${NC}\n"

}

function install_APT_packages {
    printf "\n\n${GREEN}Apt packages:${NC}\n\n"

    install_media_apps
    printf "\n"

    # Linux
    aptInstall git
    aptInstall make
    aptInstall rclone
    aptInstall smartmontools
    aptInstall tmux
    aptInstall htop
    aptInstall xclip

    # Android/React-Native?
    aptInstall android-tools-adb
    aptInstall android-tools-fastboot

    # Security
    aptInstall keepassxc

    # Alerts -> notify-send
    aptInstall libnotify-bin
    aptInstall notify-osd

    # aptInstall i3
    # aptInstall dmenu

    install_kde_stuff
    printf "\n"

    # Text Editors
    aptInstall neovim
    aptInstall gedit
    aptInstall fonts-cascadia-code
    aptInstall fonts-firacode

    # Web
    aptInstall curl
    aptInstall wget
    aptInstall qbittorrent

    # Fun
    aptInstall cowsay
    aptInstall fortune

    install_office_apps
}

function install_media_apps {
    printf "\n${GREEN}Installing media apps...${NC}\n"

    aptInstall mpv
    aptInstall audacious
    aptInstall viewnior
    aptInstall qpdfview
    aptInstall mupdf
    aptInstall gimp
    # aptInstall calibre
    aptInstall obs-studio
    aptInstall kolourpaint

    sudo add-apt-repository -y ppa:jurplel/qview
    aptInstall qview
    aptInstall qt5-image-formats-plugins

    sudo apt-add-repository -y ppa:audio-recorder/ppa
    aptInstall audio-recorder

    sudo apt-add-repository ppa:marin-m/songrec -y -u
    aptInstall songrec

    printf "${GREEN}Media apps done...\n${NC}"
}

function install_kde_stuff {
    printf "\n${GREEN}Installing KDE stuff...${NC}\n"

    aptInstall dolphin
    aptInstall konsole
    aptInstall kde-cli-tools
    aptInstall ark
    printf "${GREEN}KDE stuff done...\n${NC}"
}

function install_office_apps {
    printf "\n${GREEN}Installing Office stuff...${NC}\n"
    aptInstall libreoffice-writer
    aptInstall libreoffice-calc
    aptInstall libreoffice-impress
    printf "${GREEN}Office stuff done...\n${NC}"
}

function install_snaps {
    printf "\n${GREEN}Installing Snaps...${NC}\n"
    aptInstall snapd
    snapInstall postman
    # snapInstall foliate # Mobi reader
    # snapInstall shotcut --classic # Video editing
    # snapInstall slack --classic
    # snapInstall robo3t-snap
    # snapInstall android-studio --classic
    # snapInstall lxd
    printf "${GREEN}Snaps done...\n${NC}"
}

function install_brightness_controller {
    printf "\n${GREEN}Installing brightness-controller...${NC}\n"
    # https://github.com/LordAmit/Brightness
    sudo add-apt-repository ppa:apandada1/brightness-controller -y
    sudo apt update
    aptInstall brightness-controller
    printf "${GREEN}Brightness-controller done...${NC}\n"
}

function install_vscode {
    printf "\n${GREEN}Installing VSCode...${NC}\n"
    # https://code.visualstudio.com/docs/setup/linux#_debian-and-ubuntu-based-distributions
    sudo apt-get install wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg

    sudo apt install apt-transport-https
    sudo apt update
    sudo apt install code # or code-insiders

    if ! command -v code &>/dev/null; then
        printf "VSCode ('code') could not be found\n"
        return
    fi
    printf "\n${GREEN}Installing VSCode extensions...${NC}\n"
    pwd
    bash ../vscode/install_listed_extensions.sh
}

function install_python {
    printf "\n\n${GREEN}Python3:${NC}\n\n"
    aptInstall python3-pip
    aptInstall python3.8-venv

    sudo python3 -m pip install --upgrade --no-warn-script-location \
        pip \
        pylint mypy yapf pytest \
        pandas numpy scipy scikit-learn matplotlib \
        virtualenv \
        youtube_dl
}

function install_js {
    source "$(dirname "$BASH_SOURCE")/../osCommon/common_lib_js.sh"
    __js_install_global_package="sudo $__js_install_global_package"
    # TODO: Test!

    printf "\n\n${GREEN}JavaScript:${NC}\n\n"
    # Installing Node.js & npm
    aptInstall nodejs
    aptInstall npm
    # Update npm
    sudo npm install -g --loglevel=error npm@latest

    # Installing yarn
    sudo apt remove -y cmdtest
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update && sudo apt install -y yarn

    install_js_globals
    install_js_globals_unix
    # install_js_globals_extra
}

function install_java {
    printf "\n\n${GREEN}Java:${NC}\n\n"
    aptInstall openjdk-11-jdk
    aptInstall openjfx
}

function install_rust {
    printf "\n\n${GREEN}Rust:${NC}\n\n"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

function install_go_lang {
    printf "\n\n${GREEN}Go:${NC}\n\n"
    aptInstall golang

    printf "\n\n${BLUE}Go get *packages* starting...${NC}\n\n"
    go get -v \
        golang.org/x/lint/golint \
        golang.org/x/tools/cmd/gorename \
        github.com/ramya-rao-a/go-outline \
        github.com/mdempsky/gocode \
        github.com/stamblerre/gocode \
        github.com/uudashr/gopkgs/v2/cmd/gopkgs \
        github.com/sqs/goreturns \
        github.com/rogpeppe/godef
    printf "\n${BLUE}Go get *packages* done!${NC}\n"
}

function install_c_sharp {
    printf "\n\n${GREEN}C#:${NC}\n\n"
    aptInstall mono-complete
}

function install_docker {
    printf "\n\n${GREEN}Docker:${NC}\n\n"
    # https://docs.docker.com/engine/install/ubuntu/#installation-methods

    # Remove old docker
    sudo apt remove docker docker-engine docker.io containerd runc

    # Set up the repository
    sudo apt update
    sudo apt install \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg |
        sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    echo \
        "deb [arch=$(dpkg --print-architecture) \
        signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
        https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" |
        sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

    # Install
    sudo apt update
    sudo apt install docker-ce docker-ce-cli containerd.io
}

function install_docker_compose {
    # https://docs.docker.com/compose/install/#install-compose-on-linux-systems
    sudo curl -L \
        "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" \
        -o /usr/local/bin/docker-compose

    sudo chmod +x /usr/local/bin/docker-compose
}

function wrap_up_installing {
    printf "\n\n${GREEN}Wrapping up...${NC}\n\n"

    # Purge old packages
    sudo apt purge -y gwenview vlc

    # Refresh
    sudo apt update
    sudo apt upgrade -y
    sudo apt autoremove -y
}

function aptInstall {
    printf "${GREEN}Apt-Installing: $@\n${NC}"
    sudo apt install -y $@
}

function snapInstall {
    printf "${GREEN}Snap-Installing: $@\n${NC}"
    sudo snap install $@
}

main
