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

# Old prompt
# TODO: Delete after verifying new prompt works on windows
# export PS1="\[\e[32m\][\[\e[m\]\[\e[32m\]\w\[\e[m\]\[\e[32m\]]\[\e[m\]\[\e[32m\]\\$\[\e[m\] "

prompt_time_hhmm="\A"
prompt_pwd="\w"
prompt_matija_1="$BLUE$prompt_time_hhmm $GREEN[$prompt_pwd]$RED\$ $NC"

# Prompt.
export PS1="$prompt_matija_1"

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

# ***Plugins***
# All these plugins should work both for bash and zsh!

function sourcePlugins {
    # printf "Source plugins start\n"
    # plugin_source_start_t=$SECONDS
    plugins_folder="$HOME/.bash-plugins"
    for f in "$plugins_folder"/*; do
        # echo "Added plugin: $f"
        . "$f"
    done
    # printf "sourcePlugins duration = $((SECONDS - plugin_source_start_t)) seconds.\n"
}

# sourcePlugins

# printf "Base .bashrc loading duration = $((SECONDS - bashrc_loading_start_time)) seconds.\n"
