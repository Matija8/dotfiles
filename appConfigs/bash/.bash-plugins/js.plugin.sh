function _set_NODE_PATH {
    NODE_PATH="$(npm root -g):$(yarn global dir)"
    # https://stackoverflow.com/questions/15636367/nodejs-require-a-global-module-package
    # Npm works. Yarn can't be tested (no binaries?)???
    # https://github.com/felixrieseberg/windows-build-tools/issues/154
}
# https://askubuntu.com/questions/58814/how-do-i-add-environment-variables#:~:text=To%20set%20it%20permanently%2C%20and%20system%20wide

# # https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
# if [ -z "${WAS_NODE_PATH_SET_FROM_DOTFILES_PLUGIN+x}" ]; then
#     _set_NODE_PATH
#     WAS_NODE_PATH_SET_FROM_DOTFILES_PLUGIN="YES"
#     printf "NODE_PATH set now.\n"
# else
#     :
#     printf "NODE_PATH already set.\n"
# fi
# # printf "NODE_PATH=$NODE_PATH\n\n"

# export WAS_NODE_PATH_SET_FROM_DOTFILES_PLUGIN
export NODE_PATH

function rmnode_modules {
    rm -rf ./node_modules
    rm -f package-lock.json
    rm -f yarn.lock
    dirName=$(basename "$PWD")
    echo "Removed node_modules & lock files in $dirName"
}

alias y="yarn"
alias ys="yarn start"
alias yt="yarn test"
alias yr="yarn run"
alias yga="sudo yarn global add"

alias nr="npm run"
alias ni="npm i"
# https://stackoverflow.com/questions/52499617/what-is-the-difference-between-npm-install-and-npm-ci
alias nci="npm ci"
alias nig="sudo npm i -g"     # global
alias nid="npm i -D"          # dev
alias nia="npm i && npm i -D" # "all" (prod & dev)
alias nui="npm uninstall"
alias nrt="npm run test"

alias tst="ts-node -T"

alias npmls="npm list -g --depth=0"
alias yarnls="yarn global list"

# Append name to the end of command to avoid prompt
alias cr-next-app="yarn create next-app --typescript"
