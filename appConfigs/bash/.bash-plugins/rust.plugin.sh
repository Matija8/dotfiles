if [ -d "$HOME/.cargo" ]; then
    # https://www.rust-lang.org/tools/install
    # https://doc.rust-lang.org/cargo/getting-started/installation.html
    . "$HOME/.cargo/env"
    # To check rust installation was successful:
    # rustc -V && cargo -V && rustup -V
fi
