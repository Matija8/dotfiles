# To install:
# https://www.rust-lang.org/tools/install
# https://doc.rust-lang.org/cargo/getting-started/installation.html

if [ -d "$HOME/.cargo" ]; then
    . "$HOME/.cargo/env"
    # To check rust installation was successful:
    # rustc -V && cargo -V && rustup -V

    alias cargonew="cargo new"
    alias cargorun="cargo run"
fi
