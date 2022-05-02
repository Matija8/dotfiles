function y_or_n {
    while true; do
        read -p "" yn
        case $yn in
        [Yy]*) break ;;
        [Nn]*) exit ;;
        *) echo "Please answer y(yes) or n(no)." ;;
        esac
    done
}
