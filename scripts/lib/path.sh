function saveCwd {
    _cwd="$(pwd)"
}

function goToLastSavedCwd {
    cd "$_cwd"
}

function cdCurrentSourcedScriptDir {
    cd "$(dirname "$BASH_SOURCE")"
}

function cdCurrentActiveScriptDir {
    cd "$(dirname "$0")"
}
