# To install:
# https://www.rust-lang.org/tools/install
# https://doc.rust-lang.org/cargo/getting-started/installation.html

if [ -d "$HOME/.cargo" ]; then
    . "$HOME/.cargo/env"

    # To check rust installation was successful:
    # rustc -V && cargo -V && rustup -V

    # https://doc.rust-lang.org/cargo/commands/cargo-new.html
    alias cargonew="cargo new --vcs=none"

    alias cargorun="cargo run"
    alias crr="cargo run"

    alias cargocheck="cargo check"
    alias crc="cargo check"

    function rustr {
        # Mnemonic: Rust run
        # Build and run in 1 step.
        # http://blog.joncairns.com/2015/10/a-single-command-to-compile-and-run-rust-programs/
        local name=$(basename $1 .rs)
        rustc $@ && ./$name && rm $name
    }
fi
