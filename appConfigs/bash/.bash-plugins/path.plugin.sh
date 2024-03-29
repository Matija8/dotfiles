_() {
    local __scripts_dir="$HOME/_Matija-Scripts/bin"
    PATH=$PATH:"$__scripts_dir"
    PATH=$PATH:"$__scripts_dir/ffmpeg"
    PATH=$PATH:"$__scripts_dir/ffmpeg/subtitles"
} && _ "$@"
unset -f _

# For Python packages
# https://stackoverflow.com/questions/35898734/pip-installs-packages-successfully-but-executables-not-found-from-command-line
PATH=$PATH:"$HOME/.local/bin"

# https://superuser.com/questions/153371/what-does-export-do-in-bash
export PATH

function echoPATH {
    # https://stackoverflow.com/questions/2871181/replacing-some-characters-in-a-string-with-another-character
    echo $PATH | tr : "\n"
}

# Use the "which" command to find program location on $PATH
# https://stackoverflow.com/questions/37056192/which-vs-command-v-in-bash
