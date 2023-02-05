# https://stackoverflow.com/questions/50042514/what-is-the-dockerfile-extension

# https://thenewstack.io/docker-basics-how-to-use-dockerfiles
# https://stackoverflow.com/questions/36075525/how-do-i-run-a-docker-instance-from-a-dockerfile
#
# docker build -t "dotfiles_setup" - < test_setup_all.dockerfile

# https://hub.docker.com/_/ubuntu
FROM ubuntu

# https://stackoverflow.com/questions/20635472/using-the-run-instruction-in-a-dockerfile-with-source-does-not-work
SHELL ["/bin/bash", "-c"]

RUN source <(curl -sL https://raw.githubusercontent.com/Matija8/dotfiles/main/osLinux/setup_all.sh)

# To verify it was created
# docker images

# To run image as container
# docker run dotfiles_setup

# TODO: Attach to container and debug
