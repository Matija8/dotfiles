__rclone_remote_path_prefix=""

source "$(dirname "$BASH_SOURCE")/colors.sh"

function rccheck {
    local src=$(realpath "$1")
    local dst="$__rclone_remote_path_prefix$2"
    printf "${BLUE}Checking\n local:  $src\n remote: $dst...${NC}\n\n"
    start=$SECONDS
    if
        rclone check "$src" "gdrive:$dst" \
            --exclude ".git/**" \
            --exclude ".vscode/**" \
            --exclude ".mypy_cache/**" \
            --exclude "__pycache__/**"
    then
        printf "${GREEN}Good!${NC}\n"
    else
        printf "${RED}Bad!${NC}\n"
    fi

    printf "\n${BLUE}Check done!${NC}\n"
    printf "Duration = $((SECONDS - start)) seconds.\n\n"
}

function rcbackup {
    local src=$(realpath "$1")
    local dst="$__rclone_remote_path_prefix$2"
    printf "${BLUE}Backing up\n from: $src\n to:   $dst...${NC}\n\n"
    start=$SECONDS
    if
        rclone sync "$src" "gdrive:$dst" \
            --exclude ".git/**" \
            --exclude ".vscode/**" \
            --exclude ".mypy_cache/**" \
            --exclude "__pycache__/**"
    then
        printf "${GREEN}Done!${NC}\n"
    else
        printf "${RED}Error!${NC}\n"
    fi

    printf "\n${BLUE}Backup done!${NC}\n"
    printf "Duration = $((SECONDS - start)) seconds.\n\n"
}
