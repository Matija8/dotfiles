if java -version &>/dev/null; then
    JH="$(readlink -f /usr/bin/java | sed 's:/bin/java::')"
    if [ -d "$JH" ]; then
        export JAVA_HOME="$JH"
        export JDK_HOME="$JH"
        export PATH="$JH/bin:$PATH"
        #
        # To sanity check java is in path, call both
        # java -version
        # AND!
        # javac -version
        #
        # Sometimes javac is missing, but it is important to have it (jdk).
        # Just having java means jvm is installed, but not jdk.

        # For ubuntu:
        # sudo apt install -y openjdk-17-jdk
        # or
        # sudo apt install -y openjdk-11-jdk
        # sudo apt install -y openjdk-8-jdk
        # sudo apt install -y openjdk-21-jdk
        # ...
    fi
fi
