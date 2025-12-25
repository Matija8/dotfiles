# By: Matija8
# This rc file is for bash on linux & git-bash on windows.

# Uncomment to get full loading of .bashrc duration❗
# bashrc_loading_start_time=$(date +%s%3N)
if [ -n "$bashrc_loading_start_time" ]; then
	printf "Loading bashrc started at $bashrc_loading_start_time...\n"
fi

RED='\033[0;31m'
GREEN='\033[0;32m'
LGREEN='\033[1;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

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

if [ -n "$bashrc_loading_start_time" ]; then
	printf "Base .bashrc loading duration = $(($(date +%s%3N) - bashrc_loading_start_time)) miliseconds.\n"
fi
