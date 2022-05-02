#!/usr/bin/env bash

# From: https://stackoverflow.com/questions/35773299/how-can-you-export-the-visual-studio-code-extension-list

# Set current working directory to this scripts directory.
cd "$(dirname "$0")"

install_listed_script="install_listed_extensions.sh"

#code --list-extensions | xargs -L 1 echo code --install-extension
printf "Creating '$install_listed_script' file...\n\n"
printf "#!/usr/bin/env bash\n\n" >$install_listed_script

printf "Getting extensions from vscode...\n\n"
code --list-extensions | xargs -L 1 echo code --install-extension >>$install_listed_script

printf "Making 'vscode_install_extensions.sh' an executable...\n\n"
chmod +x $install_listed_script

printf "Done!\n"
