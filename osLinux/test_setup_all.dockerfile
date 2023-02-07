# https://stackoverflow.com/questions/50042514/what-is-the-dockerfile-extension

# https://thenewstack.io/docker-basics-how-to-use-dockerfiles
# https://stackoverflow.com/questions/36075525/how-do-i-run-a-docker-instance-from-a-dockerfile
#
# docker build -t "dotfiles_setup" - < test_setup_all.dockerfile

# https://hub.docker.com/_/ubuntu
FROM ubuntu

# https://stackoverflow.com/questions/20635472/using-the-run-instruction-in-a-dockerfile-with-source-does-not-work
SHELL ["/bin/bash", "-c"]

# https://stackoverflow.com/questions/34571711/cant-run-curl-command-inside-my-docker-container
RUN apt -y update; apt -y install curl zip vim

# https://unix.stackexchange.com/questions/711574/ignore-sudo-for-each-command
# RUN alias sudo=""
RUN printf '#!/bin/bash\n$@' >/bin/sudo; chmod +x /bin/sudo

RUN source <(curl -sL https://raw.githubusercontent.com/Matija8/dotfiles/main/osLinux/setup_all.sh)

# To verify the "dotfiles_setup" image was created:
# docker images

# To run image as container ❌:
# docker run dotfiles_setup

# To run image as container interactively 👍:
# docker run -it --entrypoint ./bin/bash dotfiles_setup

# TODO: Attach to container and debug
