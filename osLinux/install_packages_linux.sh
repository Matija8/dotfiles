#!/usr/bin/env bash
# coding: UTF-8
# Bash script that installs packages for Ubuntu.

os_linux_dir="$(realpath "$(dirname "$0")")"
dotfiles_root_dir="$(realpath "$os_linux_dir/..")"
source "$dotfiles_root_dir/scripts/lib/colors.sh"

# Retry this script as root.
# ((EUID != 0)) && exec sudo -- "$0" "$@"

function main {
    if [[ "$OSTYPE" != "linux-gnu"* ]]; then
        echo -e "Your os type isn't linux?!"
        read -p "Are you sure you want to continue? (Ctrl+c to cancel)"
    fi

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

    if [ -z "${WSL_DISTRO_NAME+x}" ]; then
        install_vscode
        install_snaps
    fi

    install_js
    install_python

    check_java_installation
    check_scala_installation
    check_go_lang_installation
    check_rust_installation

    # install_docker
    # install_docker_compose

    wrap_up_installing
    printf "\n\n${PURPLE}All Done!${NC}\n"

}

function install_APT_packages {
    printf "\n\n${GREEN}Apt packages:${NC}\n\n"

    versionOrAptInstall mpv -V
    versionOrAptInstall audacious -v
    versionOrAptInstall viewnior --version
    whichOrAptInstall qpdfview
    whichOrAptInstall mupdf
    versionOrAptInstall gimp -v
    dontAptInstall calibre
    versionOrAptInstall kolourpaint -v

    if ! obs -V &>/dev/null; then aptInstall obs-studio; else printInstalledMsg obs; fi

    if ! qview -v &>/dev/null; then
        sudo add-apt-repository -y ppa:jurplel/qview
        aptInstall qview
    else
        printInstalledMsg qview
    fi

    aptListOrAptInstall qt5-image-formats-plugins

    # if ! audio-recorder -v &>/dev/null; then
    #     sudo apt-add-repository -y ppa:audio-recorder/ppa
    #     aptInstall audio-recorder
    # else
    #     printInstalledMsg audio-recorder
    # fi

    if ! songrec -V &>/dev/null; then
        sudo apt-add-repository ppa:marin-m/songrec -y -u
        aptInstall songrec
    else
        printInstalledMsg songrec
    fi

    # Linux
    versionOrAptInstall git --version
    versionOrAptInstall make -v

    versionOrAptInstall rclone version
    versionOrAptInstall tmux -V
    versionOrAptInstall htop -V

    versionOrAptInstall xclip -version

    # Hardcore
    dontAptInstall mc     # https://midnight-commander.org/
    dontAptInstall ranger # https://github.com/ranger/ranger
    dontAptInstall i3     # https://i3wm.org/
    dontAptInstall dmenu  # https://tools.suckless.org/dmenu/

    # Hard disk tools:
    #
    # smartd, smartctl
    # https://www.smartmontools.org/
    whichOrAptInstall smartctl smartmontools
    #
    # https://askubuntu.com/questions/59064/how-to-run-a-checkdisk
    whichOrAptInstall gnome-disks gnome-disk-utility

    # Android/React-Native?
    dontAptInstall android-tools-adb
    dontAptInstall android-tools-fastboot

    # Security
    versionOrAptInstall keepassxc -v

    # Alerts -> notify-send
    aptListOrAptInstall libnotify-bin
    aptListOrAptInstall notify-osd

    # KDE stuff
    versionOrAptInstall dolphin -v
    versionOrAptInstall konsole -v
    aptListOrAptInstall kde-cli-tools
    whichOrAptInstall ark

    # Text Editors
    if nvim -v &>/dev/null; then printInstalledMsg neovim; else
        # Need version > 0.5 for init.lua to work
        # https://github.com/neovim/neovim/wiki/Installing-Neovim#ubuntu
        sudo add-apt-repository ppa:neovim-ppa/stable -y
        aptInstall neovim
    fi
    versionOrAptInstall gedit -V
    aptListOrAptInstall fonts-cascadia-code
    aptListOrAptInstall fonts-firacode

    # Web
    versionOrAptInstall curl -V
    versionOrAptInstall wget -V
    whichOrAptInstall nmap
    versionOrAptInstall qbittorrent -v

    # Fun
    aptListOrAptInstall cowsay
    aptListOrAptInstall fortune

    # Office
    aptListOrAptInstall libreoffice-writer
    aptListOrAptInstall libreoffice-calc
    aptListOrAptInstall libreoffice-impress
}

function install_snaps {
    printf "\n${GREEN}Installing Snaps...${NC}\n"

    if ! snap version &>/dev/null; then aptInstall snapd; fi

    snapListOrsnapInstall postman
    # snapListOrsnapInstall foliate # Mobi reader
    # snapListOrsnapInstall shotcut --classic # Video editing
    # snapListOrsnapInstall slack --classic
    # snapListOrsnapInstall robo3t-snap
    # snapListOrsnapInstall android-studio --classic
    # snapListOrsnapInstall lxd
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
    if command -v code &>/dev/null; then
        printInstalledMsg "vscode"
        return
    fi

    printf "\n${GREEN}Installing VSCode...${NC}\n"
    # https://code.visualstudio.com/docs/setup/linux#_debian-and-ubuntu-based-distributions
    whichOrAptInstall wget
    whichOrAptInstall gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg

    aptInstall apt-transport-https
    sudo apt update
    aptInstall code # or code-insiders

    if ! command -v code &>/dev/null; then
        printf "VSCode ('code') could not be found\n"
        return
    fi
    printf "\n${GREEN}Installing VSCode extensions...${NC}\n"
    bash "$dotfiles_root_dir/vscode/install_listed_extensions.sh"
}

function install_python {
    printGreenHeader "Python"

    if ! pip -V; then aptInstall python3-pip; fi

    # https://docs.python.org/3/library/venv.html
    # aptInstall python3.8-venv

    source "$dotfiles_root_dir/osCommon/common_lib_py.sh"
    __py_install_global_packages="sudo python3 -m pip install"
    install_python_globals
}

function install_js {
    printGreenHeader "JavaScript"

    if ! node -v &>/dev/null; then
        printf "${RED}Node.js *not* installed ❌... ${GREEN}yet!${NC}\n\n"
        # https://nodejs.org/en/download/ -> click on link "Installing Node.js via package manager" ->
        # -> https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions ->
        # -> https://github.com/nodesource/distributions/blob/master/README.md#using-ubuntu
        curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
        aptInstall nodejs
        aptInstall npm
    fi

    if ! npm -v &>/dev/null; then
        printf "${RED}Npm *not* installed!? ❌ ${NC}\n\n"
    else
        # Update npm
        # https://docs.npmjs.com/cli/v8/using-npm/config#shorthands-and-other-cli-niceties
        sudo npm install -g --loglevel=silent npm@latest
    fi

    if ! deno -V &>/dev/null; then
        printf "${RED}Deno *not* installed ❌... ${GREEN}yet!${NC}\n\n"
        # https://deno.land/manual/getting_started/installation
        curl -fsSL https://deno.land/x/install/install.sh | sh
    fi

    if ! yarn -v &>/dev/null; then
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

function check_java_installation {
    printGreenHeader "Java"
    if java --version; then
        printInstalledMsg "Java"
        return
    fi
    printNotInstalledMsg "Java"
    # https://dev.java/learn/getting-started/#setting-up-jdk
}

function check_scala_installation {
    printGreenHeader "Scala"
    # sbt -V # slow
    if scala -version && scalac -version && cs version; then
        printInstalledMsg "Scala"
        return
    fi
    printNotInstalledMsg "Scala"
    # https://docs.scala-lang.org/getting-started/
}

function check_go_lang_installation {
    printGreenHeader "Go-lang"
    if go version; then
        printInstalledMsg "Go-lang"
        return
    fi
    printNotInstalledMsg "Go-lang"
    # https://go.dev/doc/install
}

function check_rust_installation {
    printGreenHeader "Rust"
    # printf "\n\n${GREEN}Rust:${NC}\n\n"
    if rustc -V && cargo -V && rustup -V; then
        printInstalledMsg "Rust"
        return
    fi
    printNotInstalledMsg "Rust"
    # https://www.rust-lang.org/tools/install
    # https://doc.rust-lang.org/cargo/getting-started/installation.html
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
    # https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository
    # https://docs.docker.com/engine/install/linux-postinstall

    # Remove old docker
    sudo apt remove docker docker.io containerd runc
    sudo apt remove docker-engine # This might error in apt, that is why it's seperate

    # Set up the repository
    sudo apt update
    sudo apt install ca-certificates curl gnupg lsb-release

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

    # You might need to restart your computer now to use docker without sudo.

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

    # https://docs.docker.com/compose/install/other/
    local docker_compose_bin_path="/usr/local/bin/docker-compose"

    sudo curl -SL \
        "https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-$(uname -s)-$(uname -m)" \
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

function versionOrAptInstall {
    if $@ &>/dev/null; then
        printInstalledMsg $1
        return
    fi
    printNotInstalledMsg $1
    aptInstall $1
}

function whichOrAptInstall {
    # https://stackoverflow.com/questions/37056192/which-vs-command-v-in-bash
    if command -v $1 &>/dev/null; then
        printInstalledMsg $1
        return
    fi
    printNotInstalledMsg $1
    if [ "$#" -eq 1 ]; then aptInstall $1; else aptInstall $2; fi
}

function aptListOrAptInstall {
    # https://askubuntu.com/questions/423355/how-do-i-check-if-a-package-is-installed-on-my-server
    if dpkg -l $@ &>/dev/null; then
        printInstalledMsg $1
        return
    fi
    printNotInstalledMsg $1
    aptInstall $1
}

function dontAptInstall {
    return
    printf "\n${PURPLE}$1${NC} skipped.\n\n${NC}"
}

function printGreenHeader {
    printf "\n\n${PURPLE}$1:${NC}\n\n"
}

function printInstalledMsg {
    printf "\n${PURPLE}$1${GREEN} is installed 👍\n\n${NC}"
}

function printNotInstalledMsg {
    printf "\n${PURPLE}$1${RED} is *not* installed ❌${NC}\n\n"
}

function aptInstall {
    printf "${GREEN}Apt-Installing: ${PURPLE}$@\n${NC}"
    sudo apt install -y $@
    printf "\n"
}

function snapListOrsnapInstall {
    if snap list $1; then
        printf "${PURPLE}$1${GREEN} snap is installed 👍\n\n${NC}"
    else
        snapInstall $@
    fi
}

function snapInstall {
    printf "${GREEN}Snap-Installing: $@\n${NC}"
    sudo snap install $@
}

main
