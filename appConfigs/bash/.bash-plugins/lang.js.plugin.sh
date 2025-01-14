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

if [ -z "${NODE_PATH+x}" ]; then
    # https://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        NODE_PATH="/usr/local/lib/node_modules:$HOME/.config/yarn/global"
    elif [[ "$OSTYPE" == "msys" ]]; then
        NODE_PATH="C:\Program Files\nodejs\node_modules:$HOME\AppData\Local\Yarn\Data\global"
    fi
fi

# export WAS_NODE_PATH_SET_FROM_DOTFILES_PLUGIN
export NODE_PATH

# Add yarn global binaries to PATH
# https://github.com/yarnpkg/yarn/issues/648#issuecomment-253162900
# export PATH="$(yarn global bin):$PATH"
#
# "yarn global bin" can throw in some situations
# "error An unexpected error occurred: "Failed to replace env in config: ${CODEARTIFACT_AUTH_TOKEN}"."
# Also it's a slow command. TODO: Cache the response of "yarn global bin" on the file system?!
export PATH="$HOME/.yarn/bin:$PATH"

# https://pnpm.io/installation
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# https://deno.land/manual/getting_started/installation
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# https://bun.sh/
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

if [[ ! "$NODE_OPTIONS" =~ "max-old-space-size" ]]; then
    export NODE_OPTIONS="$NODE_OPTIONS --max-old-space-size=8192"
fi

function rmnode_modules {
    rm -rf ./node_modules
    rm -f package-lock.json
    rm -f yarn.lock
    rm -f pnpm-lock.yaml
    dirName=$(basename "$PWD")
    echo "Removed node_modules & lock files in $dirName"
}

function rmnode_modulesrecursive {
    # TODO: Depth limit for recursion?
    traverse() {
        # https://stackoverflow.com/questions/18897264/bash-writing-a-script-to-recursively-travel-a-directory-of-n-levels
        # https://stackoverflow.com/questions/8426077/how-to-define-a-function-inside-another-function-in-bash
        rm -rf "$1"/node_modules
        for file in "$1"/*; do
            if [ -d "${file}" ]; then
                echo "entering recursion with: ${file}"
                traverse "${file}"
            # else echo "${file} is not a directory"
            fi
        done
    }
    traverse "$(pwd)"
}

if command -v pnpm &>/dev/null; then
    # Pnpm docs:
    # https://pnpm.io/cli/add

    function p {
        if [ "$#" -ne 0 ]; then pnpm $@; else pnpm i; fi
    }
fi

if command -v yarn &>/dev/null; then
    # Yarn docs:
    # https://yarnpkg.com/cli/add

    alias y="yarn"
    alias ys="yarn start"
    alias yt="yarn test"
    alias yr="yarn run"
    alias yga="sudo yarn global add"
    alias yadd="yarn add"     # add "prod" dep
    alias yaddD="yarn add -D" # add dev dep
    alias ycleancache="yarn cache clean"

    alias yc="yarn config"
    function ycl {
        # The "yarn config (list)" command is super useful for debugging CodeArtifact/Nexus!

        # https://www.cyberciti.biz/faq/bash-check-if-string-starts-with-character-such-as/
        if [[ $(yarn --version) = 1* ]]; then
            # On Yarn 1.x use "yarn config list"
            # https://classic.yarnpkg.com/en/docs/cli/config
            yarn config list $@
        else
            # On Yarn >= 2.x use "yarn config"
            # https://yarnpkg.com/cli/config
            yarn config $@
        fi
    }
    alias yclv="ycl --verbose"
    alias yinfo="yarn info"

    alias yarnls="yarn global list"
fi

if command -v npm &>/dev/null; then
    # Npm docs:
    # https://docs.npmjs.com/

    alias nr="npm run"
    alias ni="npm i"
    # https://stackoverflow.com/questions/52499617/what-is-the-difference-between-npm-install-and-npm-ci
    alias nci="npm ci"
    alias nig="sudo npm i -g"     # global
    alias nid="npm i -D"          # dev
    alias nia="npm i && npm i -D" # "all" (prod & dev)
    alias nui="npm uninstall"
    alias nrt="npm run test"

    # Debugging npm/yarn/pnpm config files
    alias npmcl="npm config list"
    alias npmcll="npm config list -l" # Long (Verbose)

    # List globally installed packages:
    alias npmls="npm list -g --depth=0"
fi

alias tst="ts-node -T"

alias tsprune="npx ts-prune" # https://www.npmjs.com/package/ts-prune

function create-ts-node-in-cwd {
    # https://www.digitalocean.com/community/tutorials/typescript-new-project

    printf "node_modules/\nyarn.lock\n" >.gitignore
    pnpm init
    # yarn init -y
    pnpm add -D typescript ts-node
    # yarn add -D typescript ts-node
    npx tsc --init
    touch main.ts
}

function create-vite-app-react {
    # https://vitejs.dev/guide/#scaffolding-your-first-vite-project
    # https://github.com/vitejs/awesome-vite#templates
    ls -1
    local project_name="$1"
    pnpm create vite --template react-ts "$project_name"
    if [ $? -ne 0 ]; then return 1; fi
    if [ "$project_name" != "" ]; then code "$project_name"; fi
}

alias cvar="create-vite-app-react"
alias cvav="pnpm create vite --template vue-ts"
alias cvas="pnpm create vite --template svelte-ts"

function create-next-app {
    # https://nextjs.org/docs/basic-features/typescript#create-next-app-support
    # Append name to the end of command to avoid prompt
    # Dot "." is a valid project name.
    ls -1
    local project_name="$1"
    yarn create next-app --typescript "$project_name" || return 1
    if [ "$project_name" != "" ]; then code "$project_name"; fi
}

function create-t3-app {
    # https://beta.create.t3.gg/en/installation#yarn
    ls -1
    local project_name="$1"
    yarn create t3-app "$project_name" || return 1
    if [ "$project_name" != "" ]; then code "$project_name"; fi
}

function create-redwood-app {
    # https://redwoodjs.com/docs/tutorial/chapter1/installation
    ls -1
    local project_name="$1"
    yarn create redwood-app --ts "$project_name" || return 1
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

function decodeUri {
    # https://nodejs.org/api/cli.html#-e---eval-script
    #
    # Test for this:
    # decodeUri "response_type=code&client_id=0RZ7rE2vqbaWnz2ck40WQVIz7ikoxWWr&redirect_uri=https%3A%2F%2Fpr-1185--specialk.dev.cs-int-592.com%2Foauth&scope=categorize_image%20read%3Aall_people%20read%3Aall_data_master%20write%3Aall_data_master%20read%3Aall_data_version%20write%3Aall_data_version%20read%3Aall_data_batch%20write%3Aall_data_batch&state=oauth-1669206874215"
    #
    # Inputs need to be inside quotes, f.e. "URI".
    #
    node -e "'$1' && console.log('\n' + decodeURIComponent('$1'))"
}

function svgrcurrentdir {
    # https://react-svgr.com/docs/cli/
    # local svgdir=$1 # Specify dir?
    npx @svgr/cli --icon \
        --typescript \
        --replace-attr-values "#000=currentColor" \
        --ignore-existing --no-index \
        --out-dir ./ ./
}
