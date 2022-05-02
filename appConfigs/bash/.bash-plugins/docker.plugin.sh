which docker &>/dev/null
if [ $? -eq "0" ]; then
    alias docker-rm-all="docker rm -f $(docker ps -a -q)"
fi
