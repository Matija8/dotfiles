import os.path as osp
import unittest


def make_out_file_path_suffixed(in_file_path: str, suffix: str):
    out_path, extension = osp.splitext(in_file_path)
    return f'{out_path}{suffix}{extension}'


def make_out_file_path_prefixed(in_file_path: str, prefix: str):
    in_file_dir, in_file_name = osp.split(in_file_path)
    return osp.join(in_file_dir, f'{prefix}{in_file_name}')


def make_out_file_path_suffixed_inc(in_file_path: str, suffix: str):
    out_path = make_out_file_path_suffixed(in_file_path, suffix)
    i = 1
    while osp.exists(out_path):
        out_path = make_out_file_path_suffixed(in_file_path, f'{suffix}({i})')
        i += 1
    return out_path


class Test(unittest.TestCase):

    def test_out_suffix(self):
        given = make_out_file_path_suffixed('/asd/foo.txt', '-bar')
        self.assertEqual(given, '/asd/foo-bar.txt')

    def test_out_prefix(self):
        given = make_out_file_path_prefixed('/asd/bar.txt', 'foo-')
        self.assertEqual(given, '/asd/foo-bar.txt')

    def test_out_suffix_inc_exists(self):
        given = make_out_file_path_suffixed_inc(__file__, '')
        self.assertEqual(osp.relpath(given), 'filename(1).py')


if __name__ == '__main__':
    unittest.main()
