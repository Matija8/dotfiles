import os
import os.path as osp
import shutil
from pathlib import Path

PathStr = str


def isdir(dir_path: PathStr) -> bool:
    return osp.isdir(dir_path)


def link_dir(src: PathStr, dest: PathStr) -> None:
    try_remove_file(dest)
    os.symlink(osp.realpath(src), osp.realpath(dest))


def mkdir_nested(dir_path: PathStr) -> None:
    ''' Make directory. Does nothing if directory exists. '''
    Path(dir_path).mkdir(parents=True, exist_ok=True)


def copy_file(src: PathStr, dest: PathStr) -> None:
    try_remove_file(dest)
    shutil.copyfile(src, dest)


def link_file(file_to_link: PathStr, link_dest: PathStr) -> None:
    try_remove_file(link_dest)
    os.link(src=file_to_link, dst=link_dest)


def try_remove_file(dest: PathStr):
    if osp.exists(dest):
        rmfile(dest)


def try_remove_dir(dest: PathStr):
    if osp.exists(dest):
        rmdir_r(dest)


def try_remove_file_or_dir(dest: PathStr):
    if not osp.exists(dest):
        return
    if isdir(dest):
        rmdir_r(dest)
    rmfile(dest)


def rmdir_r(dir_path: PathStr) -> None:
    shutil.rmtree(dir_path)


def rmfile(dest: PathStr) -> None:
    os.remove(dest)
