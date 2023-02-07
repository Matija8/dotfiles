if command -v docker &>/dev/null; then

    # To sanity check docker, run:
    # docker run hello-world
    # https://hub.docker.com/_/hello-world
    alias docker-test="docker run hello-world"

    # You cannot start a container from a Dockerfile.
    # The process goes like this:
    # Dockerfile =[docker build]=> Docker image =[docker run]=> Docker container

    # Building images:
    # https://stackoverflow.com/questions/36075525/how-do-i-run-a-docker-instance-from-a-dockerfile
    # You can add -t TAG_NAME to add a tag to the image
    #
    # "docker build from pipe" mnemonic. Don't forget -t at the end!
    alias dbfp="docker build - <"
    # "docker build from current dir" mnemonic. Requires tag name at the end.
    alias dbfc="docker build . -t"

    # Running containers from images:
    #
    # For most of these commands, add a TAG_NAME or ID at the end
    alias drun="docker run"

    function drunit {
        # Pawels command. Interactive, shell mode.
        # "docker run -it" starts a container and opens a shell (*runs a command).
        # If you already have a running container, you can use "docker exec".
        # Some containers exit right away (ubuntu), so "docker exec" doesn't work, only "docker run".
        # Prefer `docker exec` to `docker run` if possible, to not create too many containers.
        # By default opens "sh". When inside you can switch to bash, if your image has it.
        #
        # docker run --help
        docker run -it --entrypoint ./bin/sh $@
    }

    function dexecit {
        # https://stackoverflow.com/questions/30172605/how-do-i-get-into-a-docker-containers-shell
        # https://stackoverflow.com/questions/20813486/exploring-docker-containers-file-system
        # https://docs.docker.com/engine/reference/commandline/exec/
        # Must be run on an already running container. Otherwise use "docker run -it".
        #
        # docker exec -it <mycontainer> bash
        # docker exec --help
        local container_name="$1"
        docker exec -it "$container_name" ./bin/sh
    }

    # Container ops:
    alias dpsa="docker ps -a" # List containers
    alias docker-psa="docker ps -a"
    alias drmf="docker rm -f" # Remove containers

    # Image ops:
    alias dim="docker image"
    alias dimage="docker image"
    # List images
    alias dims="docker image ls"
    alias dimls="docker image ls" # Same as `docker images`
    alias docker-images="docker images"
    # Deleting images
    alias dimrm="docker image rm"
    # https://docs.docker.com/engine/reference/commandline/image_rm/

    # https://stackoverflow.com/questions/20111063/bash-alias-command-with-both-single-and-double-quotes
    # Be careful with aliases that contain $() in them! Don't use "" quotes then!
    alias docker-stop-all='docker stop $(docker ps -aq)'
    alias docker-rm-all='docker rm -f $(docker ps -aq)'
    alias drmf-all='docker rm -f $(docker ps -aq)' # Remove all containers
    # TODO: Don't require sudo on linux?
    alias docker-rm-allsu='sudo docker rm -f $(sudo docker ps -aq)'

    # If you get any errors, checkout:
    # https://docs.docker.com/engine/install/linux-postinstall

    # WSL2 Start Docker
    # https://stackoverflow.com/questions/44678725/cannot-connect-to-the-docker-daemon-at-unix-var-run-docker-sock-is-the-docker
    # https://unix.stackexchange.com/questions/269805/how-can-i-detach-a-process-from-a-bash-script
    #
    # alias docker-wsl2-start="sudo dockerd & disown"
    alias docker-wsl2-start="sudo dockerd"

fi
