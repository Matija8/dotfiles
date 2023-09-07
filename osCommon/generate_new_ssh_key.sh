#!/usr/bin/env bash
# coding: UTF-8

# GitHub docs:
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh

SSH_KEY_NAME="github"
# Or gitlab, matija-ssh-key1...

function main {

    mkdir -p ~/.ssh

    # First check if you already have an ssh key
    if ls -a ~/.ssh/*.pub &>/dev/null; then
        echo -e "Existing public ssh key files:\n"
        ls -a ~/.ssh/*.pub
        echo -e ""
        read -p "Are you sure you want to create a new ssh key? (Ctrl+c to cancel)" yn
    fi

    # Generate public/private ed25519 key pair.
    echo -e "* Starting ssh-keygen operation"
    ssh-keygen -f "$HOME/.ssh/$SSH_KEY_NAME" -t ed25519 -C "matijanme@gmail.com"
    if [ $? -ne 0 ]; then exit 1; fi

    # Start the ssh-agent in the background
    echo -e "* Starting ssh-agent in the background"
    eval $(ssh-agent -s)

    # Add new key to the ssh agent.
    echo -e "* Starting ssh-add operation"
    ssh-add "~/.ssh/$SSH_KEY_NAME"

    # https://unix.stackexchange.com/questions/58969/how-to-list-keys-added-to-ssh-agent-with-ssh-add
    echo -e "\n* These are all the ssh keys you have in ssh-agent currently:"
    ssh-add -l
    echo -e ""

    displaySshKey

    # How to delete keys:
    # https://stackoverflow.com/questions/25464930/how-can-i-remove-an-ssh-key
}

function displaySshKey {
    if [ -f "~/.ssh/$SSH_KEY_NAME.pub" ]; then
        echo -e "Here is the ssh key. Paste it into GitHub/GitLab:\n"
        cat "~/.ssh/$SSH_KEY_NAME.pub"
        echo -e ""
    fi
}

main
