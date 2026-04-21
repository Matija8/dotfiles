
prompt_iife() {
    local prompt_time_hhmm="\A"
    local prompt_pwd="\w"

    local PRMPT_CLR_NC="\[\e[m\]"
    local PRMPT_CLR_RED="\[\e[31m\]"
    local PRMPT_CLR_GREEN="\[\e[32m\]"
    local PRMPT_CLR_BLUE="\[\e[34m\]"

    local blue_time_str="$PRMPT_CLR_BLUE$prompt_time_hhmm"
    local green_pwd_str="$PRMPT_CLR_GREEN[$prompt_pwd]"
    local red_dollar_str="$PRMPT_CLR_RED ~>"
    # The \n shows the prompt on a new line.
    local prompt_matija_1="$blue_time_str $green_pwd_str\n$red_dollar_str $PRMPT_CLR_NC"

    # Prompt.
    export PS1="$prompt_matija_1"
} && prompt_iife "$@"
unset -f prompt_iife
