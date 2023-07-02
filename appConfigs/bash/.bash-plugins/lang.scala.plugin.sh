# https://docs.scala-lang.org/getting-started

if cs version &>/dev/null; then
    # Commands:
    # cs, scala, scalac, sbt, sbtn, scala-cli, scalafmt, amm

    # To check scala installation was successful:
    # cs version && scalac -version && scala -version && sbt -V

    # Create an sbt project:
    # https://docs.scala-lang.org/getting-started/#create-a-hello-world-project-with-sbt
    alias sbtnew="sbt new scala/hello-world.g8"
    alias sbtnew3="sbt new scala/scala3.g8"
fi
