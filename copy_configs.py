#!/usr/bin/env python3
# coding: UTF-8
'''
Script for linking/copying config files to their .config directories.
This script should not be moved from the repo/folder containing it!
'''

import os
import os.path as osp
import shutil
import sys
from pathlib import Path
from typing import List, Tuple, Set, NamedTuple
from scripts.libPy.fs import link_file, copy_file, mkdir_nested, try_remove_dir

PathStr = str

usage = '''Usage: Link/copy config files.
-h, --help     View script usage.
-l, --link     Make links (default).
-c, --copy     Copy files instead of making links.'''

ConfigDirs = NamedTuple(
    'ConfigDirs',
    [('nvim', str), ('mpv', str), ('notepad_pp', str), ('mintty', str)]
)


class Updater():

    def __init__(self, os_type: str, should_link: bool) -> None:
        set_cwd_to_script_dir()
        self._os_type = os_type
        self._app_configs_dir = './appConfigs/'
        self._config_dirs = ConfigDirs(
            nvim=f'{self._app_configs_dir}/nvim',
            mpv=f'{self._app_configs_dir}/mpv',
            notepad_pp=f'{self._app_configs_dir}/notepad++',
            mintty=f'{self._app_configs_dir}/mintty',
        )
        self._should_link = should_link
        self._bash_configs_dir = f'{self._app_configs_dir}/bash'
        # TODO: use self._updated_apps instead of immediate print()-s
        self._updated_apps = []  # type: List[str]

    def update_configs(self) -> None:
        print(f'Starting {self._os_type} update...\n')
        self._update_bash()
        self._update_scripts()
        self._update_git()
        self._update_linters()
        self._update_formatters()
        self._update_configs()
        self._log_apps_updated()
        print(f'\n{self._os_type} update done!')

    def _update_configs(self) -> None:
        raise NotImplementedError()

    def _log_apps_updated(self) -> None:
        action = 'linked' if self._should_link else 'copied'
        for app_name in self._updated_apps:
            print(f'{app_name} {action}')

    def _update_home(self, path: PathStr) -> None:
        ''' Copy/link file (/path) from here i.e. ./path to ~/path '''
        # print(f'Update home for: {path}')
        configs_home_dir = f'{self._app_configs_dir}/_home/'
        self._update_file(f'{configs_home_dir}/{path}', f'{get_home()}/{path}')

    def _update_file(self, src: PathStr, dst: PathStr) -> None:
        ''' Copy/link src to dst. '''
        if self._should_link:
            link_file(src, dst)
        else:
            copy_file(src, dst)

    def _update_folder(self, src_folder: PathStr, dst_folder: PathStr) -> None:
        '''
        Copy files (or make links)
        from src folder to dst folder.
        Throws an exception if folders on dest path are missing (doesn't create them)!
        '''
        for dirpath, _, filenames in os.walk(src_folder):
            suffix = osp.relpath(start=src_folder, path=dirpath)
            for filename in filenames:
                src = osp.join(dirpath, filename)
                dst = osp.join(dst_folder, suffix, filename)
                self._update_file(src, dst)

    def _update_folder_r(
        self, src_folder: PathStr, dst_folder: PathStr
    ) -> None:
        '''
        Copy files (or make links)
        from src folder to dst folder.
        Doesn't delete existing files in dst folder.
        '''
        for dirpath, _, filenames in os.walk(src_folder):
            suffix = osp.relpath(start=src_folder, path=dirpath)
            for filename in filenames:
                src = osp.join(dirpath, filename)
                dst = osp.join(dst_folder, suffix, filename)
                mkdir_nested(osp.join(dst_folder, suffix))
                self._update_file(src, dst)

    def _update_git(self) -> None:
        self._update_home('/.gitconfig')
        self._updated_apps.append('Git configs')

    def _update_linters(self) -> None:
        self._update_home('/.eslintrc')
        self._updated_apps.append('Linters')

    def _update_formatters(self) -> None:
        self._update_home('/.prettierrc')
        self._update_home('/.clang-format')
        self._update_home('/.style.yapf')
        self._update_home('/.scalafmt.conf')
        self._updated_apps.append('Formatters')

    def _update_scripts(self) -> None:
        scripts_dir = './scripts'
        scripts_dir_home = f'{get_home()}/_Matija-Scripts'

        try_remove_dir(scripts_dir_home)
        self._update_folder_r(scripts_dir, scripts_dir_home)
        # link_dir - Permission issues on windows!?
        # link_dir(scripts_dir, scripts_dir_home)
        self._updated_apps.append('Scripts')

    def _update_bash(self) -> None:
        stitched_bashrc_contents = self._get_bashrc_with_plugins_appended()
        with open(f'{get_home()}/.bashrc', 'w') as f:
            f.write(stitched_bashrc_contents)
        self._updated_apps.append('Bashrc')

    def _get_bashrc_with_plugins_appended(self) -> str:
        '''Append plugins onto base .bashrc'''

        def get_plugins_in_dir_sorted(plugins_dir: str, fname_prefix=''):
            plugins = [
                (fname_prefix + f, osp.join(plugins_dir, f))
                for f in os.listdir(plugins_dir)
                if osp.isfile(osp.join(plugins_dir, f))
            ]
            return sorted(plugins, key=lambda plugin: plugin[0])

        def get_all_plugins_sorted() -> List[Tuple[str, str]]:
            plugins = []
            bash_plugins_dir = f'{self._bash_configs_dir}/.bash-plugins'
            plugins += get_plugins_in_dir_sorted(bash_plugins_dir)

            git_ignored_bash_plugins_dir = f'{self._bash_configs_dir}/.bash-plugins-hidden'
            plugins += get_plugins_in_dir_sorted(
                git_ignored_bash_plugins_dir, fname_prefix='private-'
            )
            return plugins

        stitched_bashrc_contents = ''
        with open(f'{self._bash_configs_dir}/.bashrc') as f:
            stitched_bashrc_contents += f.read()

        for (plugin_name, plugin_path) in get_all_plugins_sorted():
            # print('Adding bash plugin:', plugin_name)
            with open(plugin_path) as f:
                plugin_contents = f.read()
                stitched_bashrc_contents += '\n' + ('#' * 80) + '\n'
                stitched_bashrc_contents += '### ' + plugin_name + '\n\n'
                stitched_bashrc_contents += plugin_contents

        stitched_bashrc_contents += (
            '\n# printf "Full .bashrc loading duration = ' +
            '$((SECONDS - bashrc_loading_start_time)) seconds.\\n"\n'
        )

        return stitched_bashrc_contents

    def _update_vscode_user_dir(self, vscode_user_dir_path: PathStr) -> None:
        if not validate_program_is_on_path('code'):
            return
        self._update_folder_r(
            f'{self._app_configs_dir}/vscode/User/', vscode_user_dir_path
        )


class LinuxUpdater(Updater):

    def __init__(self, should_link: bool) -> None:
        super().__init__('Linux', should_link)

    def _update_configs(self) -> None:
        self._update_vscode()
        self._update_nvim()
        self._update_mpv()
        self._update_qpdfview()
        self._update_gtk3()
        self._update_home('/.tmux.conf')
        self._updated_apps.append('Tmux')
        self._update_home('/.hidden')
        self._add_templates()

    def _update_vscode(self) -> None:
        vsc_user_dir = f'{get_home()}/.config/Code/User'
        self._update_vscode_user_dir(vsc_user_dir)
        self._updated_apps.append('VsCode')

    def _update_nvim(self) -> None:
        if not validate_program_is_on_path('nvim'):
            return
        nvim_target_dir = f'{get_home()}/.config/nvim'
        try_remove_dir(nvim_target_dir)
        self._update_folder_r(self._config_dirs.nvim, nvim_target_dir)
        self._updated_apps.append('Nvim')

    def _update_mpv(self) -> None:
        if not validate_program_is_on_path('mpv'):
            return
        mpv_target_dir = f'{get_home()}/.config/mpv'
        self._update_folder_r(self._config_dirs.mpv, mpv_target_dir)
        self._updated_apps.append('Mpv')

    def _update_qpdfview(self) -> None:
        if not validate_program_is_on_path('qpdfview'):
            return

        qpdf_view_dir = f'{get_home()}/.config/qpdfview'
        self._update_folder_r(
            f'{self._app_configs_dir}/qpdfview', qpdf_view_dir
        )
        self._updated_apps.append('QpdfView')

    def _add_templates(self) -> None:
        templates_dir = f'{get_home()}/Templates'
        mkdir_nested(templates_dir)
        open(f'{templates_dir}/Text File', mode='w+')

    def _update_gtk3(self) -> None:
        themesDotfilesDir = f'{self._app_configs_dir}/gtk3/themes'
        localShareDir = f'{get_home()}/.local/share'

        geditThemesTargetDir = f'{localShareDir}/gedit/styles'
        self._update_folder_r(themesDotfilesDir, geditThemesTargetDir)

        mousepadThemesTargetDir = f'{localShareDir}/gtksourceview-3.0/styles'
        self._update_folder_r(themesDotfilesDir, mousepadThemesTargetDir)


class MacUpdater(Updater):

    def __init__(self, should_link: bool) -> None:
        super().__init__('Mac', should_link)

    def _update_configs(self) -> None:
        self._update_vscode()
        self._update_nvim()
        self._update_home('/.tmux.conf')
        self._update_home('/.hidden')

    def _update_vscode(self) -> None:
        vsc_user_dir = f'{get_home()}/Library/Application Support/Code/User'
        self._update_vscode_user_dir(vsc_user_dir)

    def _update_nvim(self) -> None:
        if not validate_program_is_on_path('nvim'):
            return
        nvim_target_dir = f'{get_home()}/.config/nvim'
        self._update_folder_r(self._config_dirs.nvim, nvim_target_dir)


class WindowsUpdater(Updater):

    def __init__(self, should_link: bool) -> None:
        super().__init__('Windows', should_link)
        self.roaming = f'{get_home()}/AppData/Roaming'
        self.local = f'{get_home()}/AppData/Local'

    def _update_configs(self) -> None:
        self._update_vscode()
        self._update_npp()
        self._update_nvim()
        self._update_mpv()
        self._update_mintty()

    def _update_vscode(self) -> None:
        vsc_user_dir = f'{self.roaming}/Code/User'
        self._update_vscode_user_dir(vsc_user_dir)

    def _update_npp(self) -> None:
        npad_target_dir = f'{self.roaming}/Notepad++'
        self._update_folder_r(self._config_dirs.notepad_pp, npad_target_dir)

    def _update_nvim(self) -> None:
        if not validate_program_is_on_path('nvim'):
            return
        nvim_target_dir = f'{self.local}/nvim'
        self._update_folder_r(self._config_dirs.nvim, nvim_target_dir)

    def _update_mpv(self) -> None:
        mpv_target_dir = f'{self.roaming}/mpv'
        self._update_folder_r(self._config_dirs.mpv, mpv_target_dir)

    def _update_mintty(self) -> None:
        mintty_target_dir = f'{self.roaming}/mintty'
        mkdir_nested(mintty_target_dir)
        self._update_file(
            f'{self._config_dirs.mintty}/config.txt',
            f'{mintty_target_dir}/config'
        )


class Main():

    def __init__(self, flags: List[str]):
        should_link, print_help = self._parse_flags(flags)
        self.should_link = should_link
        self.print_help = print_help

    def main(self) -> None:
        ''' Parse flags and check os, then link/copy config files. '''

        if self.print_help:
            print(usage)
            return

        self._get_updater().update_configs()

    def _parse_flags(self, flags: List[str]) -> Tuple[bool, bool]:
        # Defaults
        should_link = True
        print_help = False

        for flag in flags:

            if flag in ['-h', '--help']:
                print_help = True
                continue

            if flag in ['-l', '--link']:
                should_link = True
                continue

            if flag in ['-c', '--copy']:
                should_link = False
                continue

            print(f'Invalid flag: {flag}')
            print(usage)
            raise Exception()

        return should_link, print_help

    def _get_updater(self) -> Updater:
        user_os = sys.platform
        wsl_in_windows = is_in_windows_fs_via_wsl()

        if user_os == 'linux' and not wsl_in_windows:
            return LinuxUpdater(self.should_link)
        if user_os == 'win32' or (user_os == 'linux' and wsl_in_windows):
            return WindowsUpdater(self.should_link)
        if user_os == 'darwin':
            return MacUpdater(self.should_link)
        print('Your os is unsupported', user_os)
        raise Exception()


def set_cwd_to_script_dir() -> None:
    ''' Set current working directory to this scripts directory. '''
    os.chdir(osp.dirname(osp.realpath(__file__)))


def get_cwd() -> str:
    return os.getcwd()


def get_abs_script_path() -> str:
    return osp.abspath(__file__)


def is_in_windows_fs_via_wsl() -> bool:
    return 'WSL_DISTRO_NAME' in os.environ and get_abs_script_path(
    ).startswith('/mnt/')


def get_home() -> str:
    if (is_in_windows_fs_via_wsl()):
        split_dirs = get_abs_script_path().split('/')
        users_idx = split_dirs.index('Users')
        return '/'.join(split_dirs[:users_idx + 2])
    return str(Path.home())


def validate_program_is_on_path(program_name: str) -> bool:
    '''Log if program is missing'''
    program_on_path = is_program_on_path(program_name)
    if not program_on_path:
        print(f'WARN: *{program_name}* not found on PATH!\n')
    return program_on_path


def is_program_on_path(program_name: str) -> bool:
    return shutil.which(program_name) is not None


if __name__ == '__main__':
    if (is_in_windows_fs_via_wsl()):
        print('Running from WSL2, but in the Windows file system!')
    flags = sys.argv[1:]
    Main(flags).main()
