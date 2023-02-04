source "$(dirname "$BASH_SOURCE")/../scripts/lib/colors.sh"

# __js_install_global_package="yarn global add"
__js_install_global_package="npm i -g"

function install_js_global {
    printf "${GREEN}Js-Installing: $@\n${NC}"
    $__js_install_global_package $@
}

function install_js_globals {

    versionOrNpmInstall depcheck --version
    versionOrNpmInstall eslint -v
    versionOrNpmInstall http-server -v
    versionOrNpmInstall kill-port -v
    versionOrNpmInstall nodemon -v
    versionOrNpmInstall npkill -v
    versionOrNpmInstall prettier -v
    versionOrNpmInstall vite -v

    whichOrNpmInstall tsc typescript

    npmListOrNpmInstall glob
    npmListOrNpmInstall node-fetch@2
    npmListOrNpmInstall ts-node
}

function install_js_globals_unix {
    npmListOrNpmInstall n
}

function install_js_globals_extra {
    npmListOrNpmInstall @angular/cli
    npmListOrNpmInstall axios
    npmListOrNpmInstall create-react-app
    npmListOrNpmInstall expo-cli
    npmListOrNpmInstall node-fetch
    npmListOrNpmInstall pm2
}

function versionOrNpmInstall {
    $@ &>/dev/null
    if [ $? -eq 0 ]; then
        printIsNpmInstalled $1
        return
    fi
    install_js_global $1
}

function whichOrNpmInstall {
    which $1 &>/dev/null
    if [ $? -eq 0 ]; then
        printIsNpmInstalled $1
        return
    fi
    if [ "$#" -eq 1 ]; then install_js_global $1; else aptInstall $2; fi
}

function npmListOrNpmInstall {
    # https://stackoverflow.com/questions/26104276/how-to-tell-if-an-npm-package-was-installed-globally-or-locally
    npm list --depth 1 --global $1 &>/dev/null
    if [ $? -eq 0 ]; then
        printIsNpmInstalled $1
        return
    fi
    install_js_global $1
}

function printIsNpmInstalled {
    printf "${PURPLE}$1${GREEN} is NPM installed 👍\n\n${NC}"
}
