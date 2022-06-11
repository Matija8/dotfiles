# which docker &>/dev/null
# if [ $? -eq "0" ]; then
#     # Do stuff you would only do if docker was installed here
#     :
# fi

# https://stackoverflow.com/questions/20111063/bash-alias-command-with-both-single-and-double-quotes
# Be careful with aliases that contain $() in them! Don't use "" quotes then!?
alias docker-rm-all='docker rm -f $(docker ps -a -q)'
# TODO: Don't require sudo on linux?
alias docker-rm-allsu='sudo docker rm -f $(sudo docker ps -a -q)'

# If you get any errors, checkout:
# https://docs.docker.com/engine/install/linux-postinstall

# TODO:
# Docker ps
# Docker attach
# Docker exec ... bash
# https://stackoverflow.com/questions/30172605/how-do-i-get-into-a-docker-containers-shell
