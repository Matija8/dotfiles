if java -version &>/dev/null; then
    JH="$(readlink -f /usr/bin/java | sed 's:/bin/java::')"
    if [ -d "$JH" ]; then
        export JAVA_HOME="$JH" JDK_HOME="$JH"
    fi
fi
