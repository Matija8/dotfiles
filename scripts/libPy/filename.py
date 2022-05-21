import os.path as osp


def make_out_file_path_suffixed(in_file_path: str, suffix: str):
    out_path, extension = osp.splitext(in_file_path)
    return f'{out_path}{suffix}{extension}'


def make_out_file_path_prefixed(in_file_path: str, prefix: str):
    in_file_dir, in_file_name = osp.split(in_file_path)
    return osp.join(in_file_dir, f'{prefix}{in_file_name}')
