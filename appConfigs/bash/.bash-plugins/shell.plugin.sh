function cdq {
    # cd quiet* on dir not existing
    cd "$1" &>/dev/null
}

function cdf {
    # cd to the parent dir of file path argument
    cd $(dirname "$1")
}

# Alias "e" is "echo -e" to have the trailing newline,
# but in scripts "printf" is just "a better version of echo".
# Use "e" for printing env vars, like $HOME, $SHELL, $USER, etc...
# https://stackoverflow.com/questions/8467424/echo-newline-in-bash-prints-literal-n
# https://unix.stackexchange.com/questions/65803/why-is-printf-better-than-echo
alias e="echo -e"

alias c="clear"
alias cls="clear"

# https://linuxhint.com/ls_colors_bash/
# https://askubuntu.com/questions/17299/what-do-the-different-colors-mean-in-ls
alias l="ls -1 --color"
alias la="ls -1a --color"

# https://stackoverflow.com/questions/185899/what-is-the-difference-between-a-symbolic-link-and-a-hard-link
# https://superuser.com/questions/81164/why-create-a-link-like-this-ln-nsf
alias lns="ln -s"
alias lnsf="ln -sf"

alias hist="history"
alias chx="chmod +x"
alias rmrf="rm -rf"

# https://stackoverflow.com/questions/3915040/how-to-obtain-the-absolute-path-of-a-file-via-shell-bash-zsh-sh
alias rp="realpath"

# https://stackoverflow.com/questions/592620/how-can-i-check-if-a-program-exists-from-a-bash-script
alias commandv="command -v"

# https://unix.stackexchange.com/questions/185764/how-do-i-get-the-size-of-a-directory-on-the-command-line
# https://serverfault.com/questions/715664/the-file-and-dir-sizes-of-du-hs-is-not-consistent-with-du-hs
# dush: disk usage summarize human-readable
alias dush="du -sh"
alias duhs="du -sh"

# https://superuser.com/questions/105367/command-sudo-su
alias sudosu="sudo su"
