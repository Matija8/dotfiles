path+=('/opt/bin')
path+=('/snap/bin')
path+=("${HOME}/.local/bin") # Mostly for python binaries.
path+=("${HOME}/_Matija-Scripts/bin")   # My custom scripts.
path+=("${HOME}/.cargo/bin") # Cargo (Rust).
path+=("$(yarn global bin)") # Yarn.
path+=("$(npm root -g)")     # Npm
# path+=("${HOME}/Library/Python/3.8/bin") # Mac python.
