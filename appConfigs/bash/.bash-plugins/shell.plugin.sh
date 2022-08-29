function cdq {
    # cd quiet* on dir not existing
    cd "$1" &>/dev/null
}

alias c="clear"
alias cls="clear"
alias l="ls -1"
alias la="ls -a"
alias hist="history"
alias chx="chmod +x"
alias rmrf="rm -rf"
# https://stackoverflow.com/questions/592620/how-can-i-check-if-a-program-exists-from-a-bash-script
alias commandv="command -v"
