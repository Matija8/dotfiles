source "$(dirname "$BASH_SOURCE")/../scripts/lib/colors.sh"

# __js_install_global_package="yarn global add"
__js_install_global_package="npm i -g"

function install_js_global {
    printf "${GREEN}Js-Installing: $@\n${NC}"
    $__js_install_global_package $@
}

function install_js_globals {
    install_js_global nodemon
    # https://www.npmjs.com/package/node-fetch/v/2.6.1
    install_js_global node-fetch@2
    install_js_global prettier
    install_js_global eslint
    install_js_global vite
    install_js_global http-server
    install_js_global npkill
    install_js_global kill-port

    # TODO
    depcheck --version
    if [ $? -ne 0 ]; then install_js_global depcheck; fi

    install_js_global glob
    install_js_global typescript
    install_js_global ts-node
}

function install_js_globals_unix {
    install_js_global n
}

function install_js_globals_extra {
    install_js_global create-react-app
    install_js_global @angular/cli
    install_js_global expo-cli
    install_js_global pm2
    install_js_global axios
    install_js_global node-fetch
}
