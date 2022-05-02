cd $(dirname "$0")

# source "$(dirname "$BASH_SOURCE")/../lib.sh"
source "$(dirname "$BASH_SOURCE")/../lib/rclone.sh"

rccheck "./" "Random/Test/Test Rclone/"
rcbackup "./" "Random/Test/Test Rclone/"
rccheck "./" "Random/Test/Test Rclone/"

__rclone_remote_path_prefix="Random/"
rccheck "./" "Test/Test Rclone/"
