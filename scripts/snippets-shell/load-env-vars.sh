#!/usr/bin/env bash
# coding: UTF-8

# https://stackoverflow.com/questions/19331497/set-environment-variables-from-file-of-key-value-pairs
# https://gist.github.com/mihow/9c7f559807069a03e302605691f85572

cd $(realpath $(dirname $0))
pwd

env_file_path="../env.txt"
if [ -f "$env_file_path" ]; then
    printf "Env file found.\n"
    export $(cat "$env_file_path" | xargs)
else
    printf "Env file NOT found!\n"
fi

printf "$SOME_ENV_VAR\n\n"
# printf "$GH_PAT\n\n"

################################################################################
# When you verify things works with the above version, then shorten it:

env_file_path="$(realpath $(dirname $0))/../env.txt"
if [ -f "$env_file_path" ]; then
    export $(cat "$env_file_path" | xargs)
else
    printf "Env file NOT found!\n"
fi

################################################################################
# Even better (IIFE):

_() {
    local env_file_path="$(realpath $(dirname $0))/../env.txt"
    if [ -f "$env_file_path" ]; then
        export $(cat "$env_file_path" | xargs)
    else
        printf "Env file NOT found!\n"
    fi
} && _ "$@"
unset -f _
