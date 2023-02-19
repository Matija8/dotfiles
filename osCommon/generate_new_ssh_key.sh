#!/usr/bin/env bash
# coding: UTF-8

# GitHub docs:
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh

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
    ssh-keygen -f ~/.ssh/github -t ed25519 -C "matijanme@gmail.com"

    # Start the ssh-agent in the background
    eval $(ssh-agent -s)

    # Add new key to the ssh agent.
    ssh-add ~/.ssh/github

    # https://unix.stackexchange.com/questions/58969/how-to-list-keys-added-to-ssh-agent-with-ssh-add
    echo -e "\nThese are all the ssh keys you have in ssh-agent currently:"
    ssh-add -l
    echo -e ""

    displaySshKey

    # How to delete keys:
    # https://stackoverflow.com/questions/25464930/how-can-i-remove-an-ssh-key
}

function displaySshKey {
    if [ -f ~/.ssh/github.pub ]; then
        echo -e "Here is the ssh key. Paste it into GitHub:\n"
        cat ~/.ssh/github.pub
        echo -e ""
    fi
}

main
