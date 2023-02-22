# By: Matija8
# This rc file is for bash on linux & git-bash on windows.

# printf "Loading bashrc started...\n"
# bashrc_loading_start_time=$SECONDS

RED='\033[0;31m'
GREEN='\033[0;32m'
LGREEN='\033[1;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

prompt_iife() {
    local prompt_time_hhmm="\A"
    local prompt_pwd="\w"

    local PRMPT_CLR_NC="\[\e[m\]"
    local PRMPT_CLR_RED="\[\e[31m\]"
    local PRMPT_CLR_GREEN="\[\e[32m\]"
    local PRMPT_CLR_BLUE="\[\e[34m\]"
    local prompt_matija_1="$PRMPT_CLR_BLUE$prompt_time_hhmm $PRMPT_CLR_GREEN[$prompt_pwd]$PRMPT_CLR_RED\$ $PRMPT_CLR_NC"

    # Prompt.
    export PS1="$prompt_matija_1"
} && prompt_iife "$@"
unset -f prompt_iife

# ***Bash specific aliases (vs Zsh)***
alias rehash="hash -r"

# TODO
# https://askubuntu.com/questions/466198/how-do-i-change-the-color-for-directories-with-ls-in-the-console
# LS_COLORS=$LS_COLORS:'di=0;35:'
# export LS_COLORS

# ***Alias auto-completion***
# TODO
# https://unix.stackexchange.com/questions/4219/how-do-i-get-bash-completion-for-command-aliases
# https://stackoverflow.com/questions/30419786/bash-alias-not-autocompleting-same-as-aliased
# https://stackoverflow.com/questions/342969/how-do-i-get-bash-completion-to-work-with-aliases
# https://gist.github.com/JuggoPop/10706934

# printf "Base .bashrc loading duration = $((SECONDS - bashrc_loading_start_time)) seconds.\n"
