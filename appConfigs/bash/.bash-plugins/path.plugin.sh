# https://superuser.com/questions/153371/what-does-export-do-in-bash
export PATH=$PATH:"$HOME/_Matija-Scripts/bin"

function echoPATH {
    # https://stackoverflow.com/questions/2871181/replacing-some-characters-in-a-string-with-another-character
    echo $PATH | tr : "\n"
}
