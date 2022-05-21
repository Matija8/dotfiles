import shutil

if (shutil.which('ffmpeg') is None):
    raise Exception('Error: FFMPEG is not on your PATH!')


def cut_video_command(input_file_path, output_file_path, from_time, to_time):
    return [
        'ffmpeg', *['-ss', from_time],
        *(['-to', to_time] if to_time != 'end' else []),
        *['-i', input_file_path], *['-async', '1'], *['-strict', '-2'],
        output_file_path
    ]


def copy_video_without_sound_cmd(input_file_path: str, output_file_path: str):
    # ffmpeg -i example.mkv -c copy -an example-nosound.mkv
    return [
        'ffmpeg', '-i', input_file_path, '-c', 'copy', '-an', output_file_path
    ]