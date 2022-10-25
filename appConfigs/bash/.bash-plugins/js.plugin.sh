function _set_NODE_PATH {
    NODE_PATH="$(npm root -g):$(yarn global dir)"
    # https://stackoverflow.com/questions/15636367/nodejs-require-a-global-module-package
    # Npm works. Yarn can't be tested (no binaries?)???
    # https://github.com/felixrieseberg/windows-build-tools/issues/154
}

function _set_NODE_PATH_system_wide_linux {
    # https://askubuntu.com/questions/58814/how-do-i-add-environment-variables#:~:text=To%20set%20it%20permanently%2C%20and%20system%20wide
    printf "Appending NODE_PATH to /etc/environment\n"
    sudo printf ""
    _set_NODE_PATH
    # https://stackoverflow.com/questions/6207573/how-to-append-output-to-the-end-of-a-text-file#:~:text=41-,Using%20tee,-with%20option%20%2Da
    echo "NODE_PATH=\"$NODE_PATH\"" | sudo tee -a /etc/environment
    sudo vim /etc/environment
    # https://superuser.com/questions/339617/how-to-reload-etc-environment-without-rebooting
    printf "\nDon't forget to logout to apply changes to /etc/environment!\n\n"
}

# https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
if [ -z "${NODE_PATH+x}" ]; then
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        NODE_PATH="/usr/local/lib/node_modules:/home/matija/.config/yarn/global"
    elif [[ "$OSTYPE" == "msys" ]]; then
        NODE_PATH="C:\Program Files\nodejs\node_modules:$HOME\AppData\Local\Yarn\Data\global"
    fi
fi

# export WAS_NODE_PATH_SET_FROM_DOTFILES_PLUGIN
export NODE_PATH

function rmnode_modules {
    rm -rf ./node_modules
    rm -f package-lock.json
    rm -f yarn.lock
    dirName=$(basename "$PWD")
    echo "Removed node_modules & lock files in $dirName"
}

function init_ts_project {
    # https://www.digitalocean.com/community/tutorials/typescript-new-project

    project_dir='new-ts-project'
    rm -rf "$project_dir"
    mkdir "$project_dir"
    cd "$project_dir"

    printf "node_modules/\nyarn.lock\n" >.gitignore
    yarn init -y
    yarn add -D typescript ts-node
    npx tsc --init

    # Copy prettier and eslint?
}

alias y="yarn"
alias ys="yarn start"
alias yt="yarn test"
alias yr="yarn run"
alias yip="yarn install --prod"
alias yga="sudo yarn global add"
alias yaddD="yarn add -D" # add dev dep
alias yaddP="yarn add"    # add "prod" dep
alias ycleancache="yarn cache clean"

alias npmcl="npm config list"
alias npmcll="npm config list -l" # Long (Verbose)
alias yc="yarn config"
function ycl {
    # The "yarn config (list)" command is super useful for debugging CodeArtifact/Nexus!
    # On Yarn 1.x use "yarn config list"
    # https://classic.yarnpkg.com/en/docs/cli/config
    # On Yarn >= 2.x use "yarn config"
    # https://yarnpkg.com/cli/config

    # https://stackoverflow.com/questions/4651437/how-do-i-set-a-variable-to-the-output-of-a-command-in-bash
    local _yarn_version=$(yarn --version)

    # https://www.cyberciti.biz/faq/bash-check-if-string-starts-with-character-such-as/
    if [[ $_yarn_version = 1* ]]; then
        yarn config list $@
    else
        yarn config $@
    fi
}
alias yclv="ycl --verbose"
alias yinfo="yarn info"

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

function create-next-app {
    # https://nextjs.org/docs/basic-features/typescript#create-next-app-support
    # Append name to the end of command to avoid prompt
    # Dot "." is a valid project name.
    ls -1
    local project_name="$1"
    yarn create next-app --typescript "$project_name"
    if [ $? -ne 0 ]; then return 1; fi
    if [ "$project_name" != "" ]; then code "$project_name"; fi
}

function create-vite-app-react {
    # https://vitejs.dev/guide/#scaffolding-your-first-vite-project
    # https://github.com/vitejs/awesome-vite#templates
    ls -1
    local project_name="$1"
    yarn create vite --template react-ts "$project_name"
    if [ $? -ne 0 ]; then return 1; fi
    if [ "$project_name" != "" ]; then code "$project_name"; fi
}

function jestSingleTest {
    # https://stackoverflow.com/questions/28725955/how-do-i-test-a-single-file-using-jest
    # yarn test -- foo.test.ts
    # npm run test -- foo.test.ts

    # If you're using yarn 3.x, npm run test will not work
    yarn test -- $1

    # If you're using test to be `jest unit` or similar, better do:
    # npx jest -- $1
    #
    # or
    # https://docs.npmjs.com/cli/v8/commands/npm-exec
    # npm exec -c "jest $1"
    # https://yarnpkg.com/cli/exec
    # yarn exec "jest $1"
}
alias jestTestSingle="jestSingleTest"

function tsCheck {
    # https://stackoverflow.com/questions/57078953/incremental-compilation-with-typescript-while-using-noemit
    # https://stackoverflow.com/questions/41542907/how-to-check-typescript-code-for-syntax-errors-from-a-command-line
    # https://www.typescriptlang.org/docs/handbook/release-notes/typescript-3-4.html#faster-subsequent-builds-with-the---incremental-flag
    local GREEN='\033[0;32m'
    local NC='\033[0m'
    printf "\n${GREEN}Starting TypeScript check...${NC}\n\n"
    local tsCheckStartTime=$SECONDS
    which tsc &>/dev/null
    if [ $? -eq "0" ]; then
        tsc --noEmit --incremental
    else
        npx tsc --noEmit --incremental
    fi
    printf "\n\n${GREEN}TypeScript check duration = $((SECONDS - tsCheckStartTime)) seconds.${NC}\n\n"
}

function upgradeNodePackages {
    # https://nodejs.dev/en/learn/update-all-the-nodejs-dependencies-to-their-latest-version
    npx npm-check-updates -u
}

# https://deno.land/
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# https://bun.sh/
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
