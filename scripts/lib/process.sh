function set_option_to_exit_whole_script_on_ctrl_c {
    # Otherwise ctrl C only exists current command
    trap "exit" INT
}
