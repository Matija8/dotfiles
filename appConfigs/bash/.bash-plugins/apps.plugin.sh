alias v="nvim"
alias cg="clang++ --std=c++17"

# https://stackoverflow.com/questions/394230/how-to-detect-the-os-from-a-bash-script
# echo "$OSTYPE"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    alias chrome="google-chrome"
    alias t="tmux"
    alias tm="tmux"
elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]]; then
    alias chrome="start chrome"
    alias exp="explorer" # File explorer.
    alias gbash="/git-bash.exe &> /dev/null"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # https://stackoverflow.com/questions/17583578/what-command-means-do-nothing-in-a-conditional-in-bash
    :
fi

# https://superuser.com/questions/365847/where-should-the-xdg-config-home-variable-be-defined
export XDG_CONFIG_HOME="$HOME/.config"

function open_localhost_port {
    xdg-open http://localhost:$1/
}
