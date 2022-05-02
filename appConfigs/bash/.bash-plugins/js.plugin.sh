# https://stackoverflow.com/questions/15636367/nodejs-require-a-global-module-package
NODE_PATH="$(npm root -g)"
NODE_PATH=$NODE_PATH:"$(yarn global dir)"
# Npm works. Yarn can't install (no binaries)?
# https://github.com/felixrieseberg/windows-build-tools/issues/154
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
