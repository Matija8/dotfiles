#!/usr/bin/env bash
# coding: UTF-8
# Bash script that installs packages for Ubuntu.

os_linux_dir="$(realpath "$(dirname "$0")")"
dotfiles_root_dir="$(realpath "$os_linux_dir/..")"
source "$dotfiles_root_dir/scripts/lib/colors.sh"

# Retry this script as root.
# ((EUID != 0)) && exec sudo -- "$0" "$@"

function main {
    trap "exit" INT
    printf "${PURPLE}Starting package installation...${NC}\n"

    # Activating sudo
    sudo printf "${PURPLE}Sudo mode success${NC}\n\n"

    # Add single installation function here to test it
    # and uncomment the `exit` below
    # install_XXX
    # exit

    # sudo apt update
    # sudo apt upgrade -y

    remove_ubuntu_ctrl_alt_LR_keybindings
    install_APT_packages
    install_snaps

    if [ -z "${WSL_DISTRO_NAME+x}" ]; then
        install_vscode
    fi

    install_python
    install_js

    check_go_lang_installation
    check_rust_installation
    # install_java

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
    aptInstallMaybe git --version
    aptInstallMaybe make -v

    aptInstallMaybe rclone version
    aptInstallMaybe tmux -V
    aptInstallMaybe htop -v

    aptInstallMaybe xclip -version

    # Hard disk tools:
    #
    # smartd, smartctl
    # https://www.smartmontools.org/
    aptInstall smartmontools
    #
    # gnome-disks
    # https://askubuntu.com/questions/59064/how-to-run-a-checkdisk
    aptInstall gnome-disk-utility

    # Android/React-Native?
    # aptInstall android-tools-adb
    # aptInstall android-tools-fastboot

    # Security
    aptInstallMaybe keepassxc -v

    # Alerts -> notify-send
    aptInstall libnotify-bin
    aptInstall notify-osd

    # aptInstall i3
    # aptInstall dmenu

    install_kde_stuff
    printf "\n"

    # Text Editors
    nvim -v
    if [ $? -ne 0 ]; then aptInstall neovim; fi
    aptInstallMaybe gedit -V
    aptInstall fonts-cascadia-code
    aptInstall fonts-firacode

    # Web
    aptInstallMaybe curl -V
    aptInstallMaybe wget -V
    aptInstall nmap
    aptInstallMaybe qbittorrent -v

    # Fun
    # aptInstall cowsay
    # aptInstall fortune

    install_office_apps
}

function install_media_apps {
    printf "\n${GREEN}Installing media apps...${NC}\n"

    aptInstallMaybe mpv -V
    aptInstallMaybe audacious -v
    aptInstallMaybe viewnior --version
    aptInstallMaybe qpdfview --help
    aptInstallMaybe mupdf -v
    aptInstallMaybe gimp -v
    # aptInstall calibre
    aptInstallMaybe kolourpaint -v

    obs -V
    if [ $? -ne 0 ]; then aptInstall obs-studio; fi

    qview -v
    if [ $? -ne 0 ]; then
        sudo add-apt-repository -y ppa:jurplel/qview
        aptInstall qview
        exit 1
    fi

    aptInstall qt5-image-formats-plugins

    audio-recorder -v
    if [ $? -ne 0 ]; then
        sudo apt-add-repository -y ppa:audio-recorder/ppa
        aptInstall audio-recorder
    fi

    songrec -V
    if [ $? -ne 0 ]; then
        sudo apt-add-repository ppa:marin-m/songrec -y -u
        aptInstall songrec
    fi

    printf "${GREEN}Media apps done...\n${NC}"
}

function install_kde_stuff {
    printf "\n${GREEN}Installing KDE stuff...${NC}\n"

    aptInstallMaybe dolphin -v
    aptInstallMaybe konsole -v
    aptInstall kde-cli-tools
    aptInstallMaybe ark -v
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

function remove_ubuntu_ctrl_alt_LR_keybindings {
    # https://stackoverflow.com/questions/592620/how-can-i-check-if-a-program-exists-from-a-bash-script
    if ! command -v gsettings &>/dev/null; then
        return
    fi

    # https://stackoverflow.com/questions/47808160/intellij-idea-ctrlaltleft-shortcut-doesnt-work-in-ubuntu
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "[]"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "[]"

    # gsettings reset org.gnome.desktop.wm.keybindings switch-to-workspace-left
    # gsettings reset org.gnome.desktop.wm.keybindings switch-to-workspace-right

    printf "\n${GREEN}Ubuntu ctrl+alt+LR keybindings removed!${NC}\n"
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
    bash "$dotfiles_root_dir/vscode/install_listed_extensions.sh"
}

function install_python {
    printf "\n\n${GREEN}Python3:${NC}\n\n"
    aptInstall python3-pip
    aptInstall python3.8-venv

    source "$dotfiles_root_dir/osCommon/common_lib_py.sh"
    __py_install_global_packages="sudo python3 -m pip install"
    install_python_globals
}

function install_js {
    printf "\n\n${GREEN}JavaScript:${NC}\n\n"
    node -v
    if [ $? -ne 0 ]; then
        printf "${RED}Node.js *not* installed ❌... ${GREEN}yet!${NC}\n\n"
        # https://nodejs.org/en/download/ -> click on link "Installing Node.js via package manager" ->
        # -> https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions ->
        # -> https://github.com/nodesource/distributions/blob/master/README.md#using-ubuntu
        curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash
        aptInstall nodejs
        aptInstall npm
    fi

    npm -v
    if [ $? -eq 0 ]; then
        # Update npm
        sudo npm install -g --loglevel=error npm@latest
    fi

    yarn -v
    if [ $? -ne 0 ]; then
        printf "${RED}Yarn *not* installed ❌... ${GREEN}yet!${NC}\n\n"
        # https://yarnpkg.com/getting-started/install
        corepack enable
    fi

    source "$dotfiles_root_dir/osCommon/common_lib_js.sh"
    __js_install_global_package="sudo $__js_install_global_package"
    install_js_globals
    install_js_globals_unix
    # install_js_globals_extra
}

function install_java {
    printf "\n\n${GREEN}Java:${NC}\n\n"
    java --version
    if [ $? -eq 0 ]; then
        printf "\n${GREEN} Java installed 👍${NC}\n\n"
        return
    fi
    # https://dev.java/learn/getting-started/#setting-up-jdk
    aptInstall openjdk-11-jdk
    aptInstall openjfx
}

function check_go_lang_installation {
    printf "\n\n${GREEN}Go-lang:${NC}\n\n"
    go version
    if [ $? -ne 0 ]; then
        "${RED}Go-lang *not* installed ❌${NC}\n\n"
        # To install follow the website:
        # https://go.dev/doc/install
        return
    fi
    printf "\n${GREEN}Go-lang installed 👍${NC}\n\n"
    return
}

function check_rust_installation {
    printf "\n\n${GREEN}Rust:${NC}\n\n"
    rustc -V && cargo -V && rustup -V
    if [ $? -ne 0 ]; then
        printf "\n${RED}Rust *not* installed! ❌${NC}\n\n"
        # To install follow the website:
        # https://www.rust-lang.org/tools/install
        # https://doc.rust-lang.org/cargo/getting-started/installation.html
        return
    fi
    printf "\n${GREEN}Rust installed 👍${NC}\n\n"
    return
}

function install_c_sharp {
    printf "\n\n${GREEN}C#:${NC}\n\n"
    # https://www.mono-project.com/download/stable/
    aptInstall gnupg ca-certificates
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
    echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" |
        sudo tee /etc/apt/sources.list.d/mono-official-stable.list
    sudo apt update
    aptInstall mono-complete
}

function install_docker {
    printf "\n\n${GREEN}Docker:${NC}\n\n"
    # https://docs.docker.com/engine/install/ubuntu/#installation-methods
    # https://docs.docker.com/engine/install/linux-postinstall

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
    sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin

    docker_allow_no_sudo
}

function docker_allow_no_sudo {
    # Post install (to use without sudo)
    # https://docs.docker.com/engine/install/linux-postinstall

    # https://linuxize.com/post/how-to-list-groups-in-linux/
    sudo groupadd docker

    # To see docker is in groups run:
    # less +/docker /etc/group
    # For less the + means pass a command, and / is search (like vim)

    # https://linuxize.com/post/usermod-command-in-linux/
    sudo usermod -aG docker $USER
    # https://linux.die.net/man/1/newgrp
    newgrp docker

    # To sanity check that docker now works without sudo, run:
    # docker run hello-world
    # docker ps -a
}

function install_docker_compose {
    # https://docs.docker.com/compose/install/#install-compose-on-linux-systems
    # https://docs.docker.com/compose/install/other/

    # echo "$(uname -s)-$(uname -m)"
    # is the same as:
    # linux-x86_64

    local docker_compose_bin_path="/usr/local/bin/docker-compose"

    sudo curl -SL \
        "https://github.com/docker/compose/releases/download/v2.12.2/docker-compose-$(uname -s)-$(uname -m)" \
        -o "$docker_compose_bin_path"

    sudo chmod +x "$docker_compose_bin_path"
}

function install_mongodb {
    printf "\n\n${GREEN}Installing mongodb...${NC}\n\n"

    # https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/
    aptInstall gnupg
    wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
    sudo apt update
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" |
        sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list

    aptInstall mongodb-org
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

function aptInstallMaybe {
    printf "${BLUE}Printing version for: ${GREEN}$1\n${NC}"
    $@
    if [ $? -ne 0 ]; then aptInstall $1; fi
}

function snapInstall {
    printf "${GREEN}Snap-Installing: $@\n${NC}"
    sudo snap install $@
}

main
