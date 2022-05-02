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
    sudo apt install -y \
        git make rclone \
        smartmontools \
        tmux htop \
        android-tools-adb android-tools-fastboot \
        xclip

    # Security
    sudo apt install -y keepassxc

    # Alerts -> notify-send
    sudo apt install -y libnotify-bin notify-osd

    # sudo apt install -y \
    #     i3 dmenu

    install_kde_stuff
    printf "\n"

    # Text Editors
    sudo apt install -y \
        neovim \
        fonts-cascadia-code \
        fonts-firacode \
        gedit

    # sudo apt install -y \
    #     neovim-qt \
    #     mousepad

    # Web
    sudo apt install -y curl wget qbittorrent

    # Fun
    sudo apt install -y \
        cowsay fortune

    install_office_apps
}

function install_media_apps {
    printf "\n${GREEN}Installing media apps...${NC}\n"

    sudo apt install -y \
        mpv audacious viewnior \
        qpdfview mupdf \
        kolourpaint4 \
        gimp \
        calibre \
        obs-studio

    sudo add-apt-repository -y ppa:jurplel/qview
    sudo apt install -y qview
    sudo apt install -y qt5-image-formats-plugins

    sudo apt-add-repository -y ppa:audio-recorder/ppa
    sudo apt install -y audio-recorder

    sudo apt-add-repository ppa:marin-m/songrec -y -u
    sudo apt install -y songrec

    printf "${GREEN}Media apps done...\n${NC}"
}

function install_kde_stuff {
    printf "\n${GREEN}Installing KDE stuff...${NC}\n"
    sudo apt install -y \
        dolphin konsole \
        kde-cli-tools ark
    printf "${GREEN}KDE stuff done...\n${NC}"
}

function install_office_apps {
    printf "\n${GREEN}Installing Office stuff...${NC}\n"
    sudo apt install -y \
        libreoffice-writer \
        libreoffice-calc \
        libreoffice-impress
    printf "${GREEN}Office stuff done...\n${NC}"
}

function install_snaps {
    printf "\n${GREEN}Installing Snaps...${NC}\n"
    sudo apt install snapd
    sudo snap install postman
    # sudo snap install foliate # Mobi reader
    # sudo snap install shotcut --classic # Video editing
    # sudo snap install slack --classic
    # sudo snap install robo3t-snap
    # sudo snap install android-studio --classic
    printf "${GREEN}Snaps done...\n${NC}"
}

function install_brightness_controller {
    printf "\n${GREEN}Installing brightness-controller...${NC}\n"
    # https://github.com/LordAmit/Brightness
    sudo add-apt-repository ppa:apandada1/brightness-controller -y
    sudo apt update
    sudo apt install brightness-controller
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
    ../vscode/install_listed_extensions.sh
}

function install_python {
    printf "\n\n${GREEN}Python3:${NC}\n\n"
    sudo apt install -y python3-pip python3.8-venv

    sudo python3 -m pip install --upgrade --no-warn-script-location \
        pip \
        pylint mypy yapf pytest \
        pandas numpy scipy scikit-learn matplotlib \
        virtualenv \
        youtube_dl
}

# js_install_global_package="sudo npm i -g"
js_install_global_package="sudo yarn global add"

function install_js {
    printf "\n\n${GREEN}JavaScript:${NC}\n\n"
    # Installing Node.js & npm
    sudo apt install -y nodejs npm
    sudo npm install -g --loglevel=error npm@latest

    # Installing yarn
    sudo apt remove -y cmdtest
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update && sudo apt install -y yarn

    $js_install_global_package \
        nodemon prettier \
        eslint \
        vite \
        http-server \
        npkill kill-port n \
        depcheck \
        glob \
        typescript ts-node

    # install_extra_js_globals
}

function install_extra_js_globals {
    $js_install_global_package \
        create-react-app \
        @angular/cli \
        expo-cli \
        pm2
}

function install_java {
    printf "\n\n${GREEN}Java:${NC}\n\n"
    sudo apt install -y \
        openjdk-11-jdk \
        openjfx
}

function install_rust {
    printf "\n\n${GREEN}Rust:${NC}\n\n"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

function install_go_lang {
    printf "\n\n${GREEN}Go:${NC}\n\n"
    sudo apt install -y golang

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
    sudo apt install mono-complete
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

main
