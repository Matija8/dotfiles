exit # snippet, don't run by accident

root_dir=$(realpath $(dirname "$0"))
cd "$root_dir"
pwd

# Copy git hooks to .git/hooks:
# cp "other/build-fe-be.sh" ".git/hooks/pre-push"
cp "other/pre-commit.sh" ".git/hooks/pre-commit"

# In the pre-commit hook you can run unit and integr. tests.

# If you're using npm workspaces, just do yarn install:
yarn install
# Subsequent yarn installs are super quick!

# If you're not using npm workspaces, use pwd to sanity check:
# cd "$root_dir/frontend"
# pwd
# yarn install
#
# cd "$root_dir/backend"
# pwd
# yarn install
