#!/usr/bin/env bash
# coding: UTF-8

# https://stackoverflow.com/questions/5735666/execute-bash-script-from-url
# source <(curl -sL https://raw.githubusercontent.com/Matija8/dotfiles/main/osLinux/setup_all.sh)

# Dirs:
# Change projects_dir to "...ProjectsX" to test script works
projects_dir="$HOME/Projects"
dotfiles_dir="$projects_dir/dotfiles"

function main {
    if [ -d "$dotfiles_dir" ]; then
        printf "\nDotfiles directory already exists!\n\n"
        read -p "Are you sure you want to continue? [y/N] " -r
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then exit 1; fi
    else
        curlDotfilesDir
        # gitCloneDotfilesDir
    fi

    # Install packages
    "$dotfiles_dir/osLinux/install_packages_linux.sh"

    # Copy configs
    "$dotfiles_dir/copy_configs.py"
}

function breakOnError {
    if [ $? -ne 0 ]; then printf "\nAn error occured!?" exit 1; fi
}

function curlDotfilesDir {
    curl -V &>/dev/null || sudo apt install curl

    mkdir -p "$projects_dir"
    cd "$projects_dir"

    # https://stackoverflow.com/questions/8557202/how-do-i-write-a-bash-script-to-download-and-unzip-file-on-a-mac
    # https://stackoverflow.com/questions/63131569/how-to-use-curl-to-download-a-raw-file-in-a-git-repository-from-git-hosting-site
    # https://stackoverflow.com/questions/74175681/downloaded-zip-size-from-a-github-release-using-curl-is-only-9-bytes

    zipFilename="dotfiles.zip"
    printf "Downloading the repo"
    curl -L --ssl-no-revoke https://github.com/Matija8/dotfiles/archive/refs/heads/main.zip -o "$zipFilename"
    breakOnError
    unzip "$zipFilename" && rm "$zipFilename"
    breakOnError
    mv dotfiles-main dotfiles
}

function gitCloneDotfilesDir {
    mkdir -p "$projects_dir"
    cd "$projects_dir"

    sudo apt install -y git
    breakOnError
    hash -r
    git clone git@github.com:Matija8/dotfiles.git
    breakOnError
}

main
