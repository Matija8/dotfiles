lib_dir="$(dirname "$BASH_SOURCE")/../lib"
source "$lib_dir/clear_port.sh"

# Turn five-server on first. Or don't.
clear_port 5555

# These should fail:
# clear_port
# clear_port 1 1
