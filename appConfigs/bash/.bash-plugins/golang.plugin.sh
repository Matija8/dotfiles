# To install:
# https://go.dev/doc/install

if [ -d "/usr/local/go" ]; then
    export PATH=$PATH:/usr/local/go/bin
    # To check go-lang installation was successful:
    # go version

    alias gorun="go run"
fi
