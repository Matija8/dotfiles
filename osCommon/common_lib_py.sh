__py_install_global_packages="pip install"

function install_python_globals {
    $__py_install_global_packages --upgrade --no-warn-script-location \
        pip \
        pylint \
        mypy \
        yapf \
        pytest \
        pandas \
        numpy \
        scipy \
        scikit-learn \
        matplotlib \
        virtualenv \
        visidata \
        youtube_dl
}
