#!/usr/bin/env bash
# coding: UTF-8

# Usage:
# (G)it* update
# Script to pull git stuff & do anything else you want...

lib_dir="$(dirname "$BASH_SOURCE")/../lib"
# https://stackoverflow.com/questions/20094271/using-dot-or-source-while-calling-another-script-what-is-the-difference
. "$lib_dir/colors.sh"
. "$lib_dir/activate-sudo-in-script.sh"

_projects_dir="$HOME/Projects"

function main {
    __br

    gpull "$_projects_dir/dotfiles/"
    gpull "$_projects_dir/Random-Projects/"
    gpull "$_projects_dir/FE-Widget-Experiments/"

    "$_projects_dir/dotfiles/copy_configs.py"

    # The x in gupdate'x' stands for 'extended'
    extended_script_path="$(dirname "$0")/gupdatex.sh"
    # https://superuser.com/questions/1068031/replace-backslash-with-forward-slash-in-a-variable-in-bash
    extended_script_path_display="${extended_script_path//\\//}"
    printf "\nExtended script path: $extended_script_path_display\n"
    if [ -f "$extended_script_path" ]; then
        printf "\n${PURPLE}Script exists. Running extended update...${NC}\n"
        . "$extended_script_path"
    fi
}

function __br {
    printf "\n*----------------------------------------------------\n"
}

function gpull {
    # https://stackoverflow.com/questions/7293008/display-last-git-commit-comment
    # https://stackoverflow.com/questions/17077973/how-to-make-git-diff-write-to-stdout
    # https://stackoverflow.com/questions/369758/how-to-trim-whitespace-from-a-bash-variable

    printf "\n${GREEN}$1${NC}\n\n"

    if [ ! -d "$1" ]; then
        # https://www.cyberciti.biz/faq/howto-check-if-a-directory-exists-in-a-bash-shellscript/
        printf "Directory [$1] is missing!?\n"
        return 1
    fi

    cd "$1"
    git status -sb &&
        git pull &&
        printf "\n${GREEN}Good${NC}" ||
        printf "\n${RED}Fail $1${NC}"
    last_commit_msg=$(git --no-pager log -1 --pretty=%B | head -1 | xargs)
    printf "\n\n${GREEN}Last commit:${NC}\n${last_commit_msg}"
    printf "\n\n\n\n\n"
}

main
