# python on win | python3 on linux??
# https://www.reddit.com/r/learnpython/comments/96h1p9/python_vs_python3_command_on_ubuntu/

PYTHON="python"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    PYTHON="python3"
    alias python="python3"
    alias py="python3"
fi

# "py" as python launcher on windows?
# https://docs.python.org/3/using/windows.html#python-launcher-for-windows
# https://docs.python.org/3/using/windows.html#shebang-lines

alias pym="$PYTHON -m"
alias pyt="$PYTHON -m pytest"
alias pip="$PYTHON -m pip"
alias pylint="$PYTHON -m pylint"
alias mypy="$PYTHON -m mypy"

alias piplist="pip list"
alias jptrnotebook="jupyter notebook"
