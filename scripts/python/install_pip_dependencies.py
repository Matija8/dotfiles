import subprocess
import sys


def install_pip_package(package: str) -> None:
    subprocess.check_call([sys.executable, '-m', 'pip', 'install', package])


def _main() -> None:
    dependencies = ['pytz', 'pyinstaller']
    for dep in dependencies:
        install_pip_package(dep)


if __name__ == '__main__':
    _main()
