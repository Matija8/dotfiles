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

# region git branch

function gfpa {
    # Mnemonic: Git Fetch Prune "All"
    # Git fetch prune and remove all local branches with "gone" remote!
    # https://stackoverflow.com/a/33548037
    git fetch -p &&
        for branch in \
            $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads |
                awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); do git branch -D $branch; done
}

function gbs {
    # Mnemonic: Git Branch list case Sensitive
    git branch -a | grep "$1"
}

function gbi {
    # Mnemonic: Git Branch list case Insensitive
    # https://stackoverflow.com/questions/48492422/how-to-grep-for-case-insensitive-string-in-a-file
    git branch -a | grep -i "$1"
}

function gbps {
    # Mnemonic: Git Branch list with prefix case sensitive (ignores remotes)
    # https://stackoverflow.com/questions/41716025/how-do-i-list-branches-having-a-common-prefix
    git branch -al "$1*"
}

function gbpi {
    # Mnemonic: Git Branch list with prefix case insensitive (ignores remotes)
    git branch -ali "$1*"
}

# TODO: gbdp, gbDp
# https://stackoverflow.com/questions/3670355/can-you-delete-multiple-branches-in-one-command-with-git
# git branch -d $(git branch -la '$1*')

function gbdp {
    # Mnemonic: Git Branch Delete Prefix
    # Delete local branches with prefix $1 that have a remote
    local branches=$(git branch -la "$1*")
    echo -e "$branches" | while read branch; do
        echo "deleting branch: $branch"
        git branch -d "$branch"
        echo ""
    done
}

function gbDp {
    # Mnemonic: Git Branch Delete Prefix
    # Delete local branches with prefix $1
    local branches=$(git branch -la "$1*")
    echo -e "$branches" | while read branch; do
        echo "deleting branch: $branch"
        git branch -D "$branch"
        echo ""
    done
}

# endregion git branch

# region git push

function gpa {
    # *** Git Push to *All* remotes ***
    # https://stackoverflow.com/questions/14290113/git-pushing-code-to-two-remotes
    # https://stackoverflow.com/questions/5785549/able-to-push-to-all-git-remotes-with-the-one-command
    local git_remotes_arr=$(git remote)
    # printf "Origins:\n$git_remotes_arr\n\n"
    # https://superuser.com/questions/284187/bash-iterating-over-lines-in-a-variable
    # https://unix.stackexchange.com/questions/184863/what-is-the-meaning-of-ifs-n-in-bash-scripting
    while IFS= read -r an_origin; do
        printf "Pushing to remote: $an_origin...\n"
        git push "$an_origin"
        printf "\n"
    done <<<"$git_remotes_arr"
}

function gpup {
    # *** Git Push UPstream ***
    local current_branch=$(git rev-parse --abbrev-ref HEAD)
    git push --set-upstream origin $current_branch

    # Examples:
    # git push --set-upstream origin some-branch-1234
    # git push --set-upstream some-remote some-branch-1234
    # git push --set-upstream gitlab-origin main

    # To see origins: git remote
}

# endregion git push

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
alias gbd='git branch -d' # Delete a local branch that has a remote
alias gbD='git branch -D' # Delete a local branch

alias gc="git commit -v"
alias gcnv="git commit -v --no-verify"

# Branch checkout
alias gco="git checkout"
alias gcb="git checkout -b" # Creates and checks out if branch doesn't exist
alias gcob="git checkout -b"
# "git checkout -B" # gcb + resets the branch (-f). Use this to override!

alias gcom="git checkout main && git pull && gfpa && git branch"

# Diff
alias gd="git diff"
alias gdc="git diff --cached"
alias gdiff="git diff"
# https://stackoverflow.com/questions/4350678/git-diff-w-ignore-whitespace-only-at-start-end-of-lines
alias gdw="git diff --ignore-space-change" # same as git diff -b, not -w!
alias gdcw="git diff --cached --ignore-space-change"
alias gdiffw="git diff --ignore-space-change"

# Fetch
alias gf="git fetch"
alias gfp="git fetch -p" # Prune!

# Commits graph
# https://stackoverflow.com/questions/4479225/how-to-output-git-log-with-the-first-line-only
alias glo="git log --oneline" # Mnmc: git log
# https://stackoverflow.com/questions/1230084/how-to-have-git-log-show-filenames-like-svn-log-v
alias glos="git log --name-status"                       # Mnmc: git log status
alias gloso="git log --name-status --oneline"            # Mnmc: git log status oneline
alias glog="git log --oneline --decorate --graph"        # Mnmc: git log graph
alias gloga="git log --oneline --decorate --graph --all" # Mnmc: git log graph all
# https://stackoverflow.com/questions/14243380/how-to-configure-git-log-to-show-commit-date
alias glop="git log --graph --pretty=format:'%C(auto)%n%h%d%n%ci%n%an%n%s'" # Mnmc: git log pretty.

# Restore/Reset/Revert/Clean/Remove(rm)
#
# https://git-scm.com/docs/git-restore
# https://www.atlassian.com/git/tutorials/undoing-changes/git-reset
# https://www.atlassian.com/git/tutorials/undoing-changes/git-revert
# https://www.atlassian.com/git/tutorials/undoing-changes/git-clean
#
# Reverting git revert (reflog)
# https://stackoverflow.com/questions/2510276/how-do-i-undo-git-reset
#
# git reset 'HEAD@{1}'
#
# https://stackoverflow.com/questions/52704/how-do-i-discard-unstaged-changes-in-git
alias grst="git restore"
# https://www.atlassian.com/git/tutorials/undoing-changes/git-rm
alias grm="git rm"

alias gl="git pull"
alias glpa="git pull && gfpa"
alias gp="git push"
# "git push -f" # Force* push!
# Setting the default remote for push:
# git push -u <remote_name> <branch_name>
# gp -u origin main
# https://stackoverflow.com/questions/18801147/changing-the-git-remote-push-to-default

alias gm="git merge"
alias grb="git rebase"
alias gcp="git cherry-pick"

# Remotes
#
# List remotes
alias gremote="git remote -v"
#
# Remove remote
# https://stackoverflow.com/questions/16330404/how-to-remove-remote-origin-from-a-git-repository
# git remote remove origin-name

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
