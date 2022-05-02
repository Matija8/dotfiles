#!/usr/bin/env bash
# coding: UTF-8

function activateSudo {
    # Add this only to gitignored scripts, or scripts not inside a git repo!
    local passwd="$1"
    echo "$passwd" | sudo -S printf "\nSudo active!\n"
}

# Example:
# activateSudo "FAKE PASSWORD; NEVER COMMIT YOUR REAL PASSWORD!"
