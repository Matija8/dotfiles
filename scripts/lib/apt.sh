source "$(dirname "$BASH_SOURCE")/colors.sh"

function updateAptPackages {
    trap "exit" INT

    printf "\n${GREEN}Starting Apt update...${NC}\n"

    sudo printf "\n\n${RED}Update:${NC}\n\n"
    sudo apt update

    printf "\n\n${RED}Upgrade:${NC}\n\n"
    sudo apt upgrade -y

    printf "\n\n${RED}Autoremove:${NC}\n\n"
    sudo apt autoremove -y

    printf "\n\n${GREEN}Apt update done!${NC}\n\n"

}
