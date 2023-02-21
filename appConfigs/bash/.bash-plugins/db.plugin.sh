if command -v docker &>/dev/null; then
    function adminer_start {
        local container_name="adminer1"
        # https://stackoverflow.com/questions/43721513/how-to-check-if-the-docker-engine-and-a-docker-container-are-running
        if [ "$(docker container inspect -f '{{.State.Running}}' $container_name)" == "true" ]; then
            echo -e "Adminer already running"
            return 0
        fi
        docker run --name "$container_name" -p 8080:8080 $@ -d adminer
    }
fi
