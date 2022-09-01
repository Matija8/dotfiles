function cdq {
    # cd quiet* on dir not existing
    cd "$1" &>/dev/null
}

alias c="clear"
alias cls="clear"
alias l="ls -1"
alias la="ls -1a"
alias hist="history"
alias chx="chmod +x"
alias rmrf="rm -rf"
# https://stackoverflow.com/questions/592620/how-can-i-check-if-a-program-exists-from-a-bash-script
alias commandv="command -v"
# https://unix.stackexchange.com/questions/185764/how-do-i-get-the-size-of-a-directory-on-the-command-line
# https://serverfault.com/questions/715664/the-file-and-dir-sizes-of-du-hs-is-not-consistent-with-du-hs
# dush: disk usage summarize human-readable
alias dush="du -sh"
alias duhs="du -sh"
