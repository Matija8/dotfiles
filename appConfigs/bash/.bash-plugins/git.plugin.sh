# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh

# alias gs="git status"
function gs {
    is_git_dir="$(git rev-parse --is-inside-work-tree 2>/dev/null)"
    if [ "$is_git_dir" != "true" ]; then
        echo "Not a git repo!"
        return 0
    fi
    git status -sb
    # https://stackoverflow.com/questions/7293008/display-last-git-commit-comment
    last_commit_msg=$(git --no-pager log -1 --oneline --pretty=%B)
    printf "\n${GREEN}Last commit:${NC}\n${last_commit_msg}\n\n"
}

function gfpa {
    # *** Git fetch prune `all` ***
    # Git fetch prune and
    # remove all local branches with `gone` remote!
    # https://stackoverflow.com/a/33548037
    git fetch -p &&
        for branch in \
            $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads |
                awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); do git branch -D $branch; done
}

function gbs {
    # *** Git branch case sensitive ***
    # https://stackoverflow.com/questions/41716025/how-do-i-list-branches-having-a-common-prefix
    git branch -a | grep "$1"
}

function gbi {
    # *** Git branch case insensitive  ***
    # https://stackoverflow.com/questions/48492422/how-to-grep-for-case-insensitive-string-in-a-file
    git branch -a | grep -i "$1"
}

function gpup {
    # *** Git push - set upstream ***
    local current_branch=$(git rev-parse --abbrev-ref HEAD)
    git push --set-upstream origin $current_branch
}

function gDeleteRemoteBranch {
    # https://www.educative.io/answers/how-to-delete-remote-branches-in-git

    if [ "$#" -ne 1 ] && [ "$#" -ne 2 ]; then
        echo "Illegal number of arguments"
        echo "Is $#, should be 1 or 2"
        return 1
    fi

    local branch_to_delete="$1"
    # local remote=${$2:="origin"}
    local remote="origin"
    echo "Deleting branch $branch_to_delete on remote $remote"
    git push "$remote" --delete "$branch_to_delete"
}

# https://stackoverflow.com/questions/592620/how-can-i-check-if-a-program-exists-from-a-bash-script
# https://git-scm.com/docs/git-config#Documentation/git-config.txt-coreeditor
if command -v nvim &>/dev/null; then
    GIT_EDITOR="nvim"
else
    GIT_EDITOR="vim"
fi
export GIT_EDITOR

alias g="git"

alias ga="git add"
alias gaa="git add -A"

# Branches immutable
alias gb="git branch"      # Show local branches
alias gbl="git branch"     # Show local branches
alias gbr='git branch -r'  # Show remote branches
alias gba='git branch -a'  # Show all branches (local + remote)
alias gbm='gbi matija'     # Show branches with name containing 'matija'
alias gbv="git branch -vv" # Show local branches info

# Branches mutable
alias gbd='git branch -d'  # Delete a local branch that has a remote
alias gbD='git branch -D'  # Delete a local branch

alias gc="git commit -v"

# Branch checkout
alias gco="git checkout"
alias gcb="git checkout -b" # Creates and checks out if branch doesn't exist
alias gcob="git checkout -b"
# "git checkout -B" # gcb + resets the branch (-f). Use this to override!

# Diff
alias gd="git diff"
alias gdc="git diff --cached"
alias gdiff="git diff"

# Fetch
alias gf="git fetch"
alias gfp="git fetch -p" # Prune!

# Commits graph
alias glo="git log --oneline --decorate --graph"
alias glog="git log --oneline --decorate --graph"
alias gloga="git log --oneline --decorate --graph --all"

alias gl="git pull"
alias gp="git push"
# "git push -f" # Force* push!

alias gm="git merge"
alias grb="git rebase"
alias grm="git rm"

# Stash immutable
alias gst="git stash"        # Save changes to stash, same as push
alias gsts="git stash show"  # Inspect stash
alias gstl="git stash list"  # List all stashes
alias gstls="git stash list" # List all stashes

# Stash mutable
alias gsta="git stash apply"   # Apply stash to top of current working tree
alias gstpush="git stash push" # Save stash and revert to HEAD
alias gstpop="git stash pop"   # Apply & drop - Opposite of push
alias gstc="git stash clear"   # Delete all stashes
alias gstd="git stash drop"    # Delete specific stash, or the latest stash

alias gclone="git clone"
alias ginit="git init"
alias gremote="git remote -v"
