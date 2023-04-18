if command -v kubectl &>/dev/null; then

    # Load K8s auto complete:
    # https://kubernetes.io/docs/reference/kubectl/cheatsheet/#kubectl-autocomplete
    # source <(kubectl completion bash)

    alias kctl="kubectl"
    alias kctlg="kubectl get"

    alias kctlgp="kubectl get pods"
    alias kctlgpa="kubectl get pods -A"

    alias kctlgs="kubectl get services"
    alias kctlgsa="kubectl get services -A"

fi
