#!/usr/bin/env bash
# coding: UTF-8

# Colors:
RED='\033[0;31m'
GREEN='\033[0;32m'
LGREEN='\033[1;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

# Set current working directory to this scripts directory.
cd "$(dirname "$0")"

function main() {
    printf "${GREEN}Starting mac packages installation...\n${NC}"

    if ! command -v brew &>/dev/null; then
        install_brew
    fi

    printf "\nInstalling Neovim...\n\n"
    brew install neovim
    printf "\nNeovim done!...\n"

    printf "${GREEN}\n\nMac packages installation done!\n${NC}"
}

function install_brew() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

main
