# which docker &>/dev/null
# if [ $? -eq "0" ]; then
#     # Do stuff you would only do if docker was installed here
#     :
# fi

# To sanity check docker, run:
# docker run hello-world

alias docker-psa="docker ps -a"
alias dpsa="docker ps -a"

# https://stackoverflow.com/questions/20111063/bash-alias-command-with-both-single-and-double-quotes
# Be careful with aliases that contain $() in them! Don't use "" quotes then!
alias docker-rm-all='docker rm -f $(docker ps -a -q)'
# TODO: Don't require sudo on linux?
alias docker-rm-allsu='sudo docker rm -f $(sudo docker ps -a -q)'

# If you get any errors, checkout:
# https://docs.docker.com/engine/install/linux-postinstall

# WSL2 Start Docker
# https://stackoverflow.com/questions/44678725/cannot-connect-to-the-docker-daemon-at-unix-var-run-docker-sock-is-the-docker
# https://unix.stackexchange.com/questions/269805/how-can-i-detach-a-process-from-a-bash-script

alias docker-wsl2-start="sudo dockerd & disown"

# TODO:
# Docker attach
# Docker exec ... bash
# https://stackoverflow.com/questions/30172605/how-do-i-get-into-a-docker-containers-shell
