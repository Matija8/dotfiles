cd $(dirname "$0")

lib_dir="$(dirname "$BASH_SOURCE")/../lib"
source "$lib_dir/colors.sh"

printf "\n"

printf "${RED}RED${NC}\n"
printf "${GREEN}GREEN${NC}\n"
printf "${LGREEN}LGREEN${NC}\n"
printf "${BLUE}BLUE${NC}\n"
printf "${PURPLE}PURPLE${NC}\n"

printf "\n"

printInColor $RED "printfInColor RED\n"
printInColor $LGREEN "printfInColor LGREEN\n"

printf "\n"

printGreen "printGreen\n"

printf "\n"
