#!/usr/bin/env bash
# coding: UTF-8

# https://stackoverflow.com/questions/36746857/completely-uninstall-vs-code-extensions

printf "Are you sure?\nIf yes, remove the \`exit\` command\n"
exit

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    rm -rf ~/.vscode/extensions
elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]]; then
    # TODO: WSL2?
    rm -rf ~/.vscode/extensions
fi
