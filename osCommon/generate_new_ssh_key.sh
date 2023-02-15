#!/usr/bin/env bash
# coding: UTF-8

# GitHub docs:
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh

function main {

    # First check if you already have an ssh key
    if ls -a ~/.ssh/*.pub &>/dev/null; then
        echo -e "Existing public ssh key files:\n"
        ls -a ~/.ssh/*.pub
        echo -e ""
        read -p "Are you sure you want to create a new ssh key? (Ctrl+c to cancel)" yn
    fi

    # Generate public/private ed25519 key pair.
    ssh-keygen -t ed25519 -C "matijanme@gmail.com"

    # Start the ssh-agent in the background
    eval $(ssh-agent -s)

    # Add new key to the ssh agent.
    ssh-add ~/.ssh/id_ed25519

    displaySshKey
}

function displaySshKey {
    gh_ssh_key_file="$HOME/.ssh/id_ed25519.pub"
    if [ -f "$gh_ssh_key_file" ]; then
        echo -e "Here is the ssh key. Paste it into GitHub:\n"
        cat "$gh_ssh_key_file"
        echo -e ""
    fi
}

main
