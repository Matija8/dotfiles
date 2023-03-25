# To install:
# https://go.dev/doc/install

if [ -d "/usr/local/go" ]; then
    # if ! command -v go &>/dev/null; then

    export PATH=$PATH:/usr/local/go/bin
    # To check go-lang installation was successful:
    # go version

    alias gorun="go run"

    function gomodinit {
        # Go packages docs:
        # https://pkg.go.dev/about#best-practices
        # https://go.dev/blog/using-go-modules
        if [[ $# -eq 0 ]]; then
            printf "\nPlease provide the Go module name.\n\n"
            return
        fi
        if [ -d "$1" ]; then
            printf "\nDir "$1" already exists.\n\n"
            return
        fi
        mkdir $1
        if [ $? -ne 0 ]; then exit 1; fi
        cd $1
        go mod init $@
    }
fi
