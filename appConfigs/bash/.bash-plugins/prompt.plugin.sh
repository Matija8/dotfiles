
prompt_iife() {
    local prompt_time_hhmm="\A"
    local prompt_pwd="\w"

    local PRMPT_CLR_NC="\[\e[m\]"
    local PRMPT_CLR_RED="\[\e[31m\]"
    local PRMPT_CLR_GREEN="\[\e[32m\]"
    local PRMPT_CLR_BLUE="\[\e[34m\]"
    local prompt_matija_1="$PRMPT_CLR_BLUE$prompt_time_hhmm $PRMPT_CLR_GREEN[$prompt_pwd]$PRMPT_CLR_RED\$ $PRMPT_CLR_NC"

    # Prompt.
    export PS1="$prompt_matija_1"
} && prompt_iife "$@"
unset -f prompt_iife
