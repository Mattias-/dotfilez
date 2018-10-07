#!/usr/bin/env python

import datetime
import os
import shutil

FILES = [
    '.bashrc',
    '.bash_profile',
    '.functions',
    '.gitconfig',
    '.gitignore_global',
    '.gitattributes_global',
    '.vim',
    '.screenrc',
    '.ssh/*',
    '.config/*',
    '.fonts',
    '.tmux.conf',
    'bin/*',
]


def main():
    base_dir = os.path.dirname(os.path.realpath(__file__))
    home_dir = os.path.expanduser('~')

    files = []
    for name in FILES:
        if name.endswith('/*'):
            dir_name = os.path.dirname(name)
            for file_name in os.listdir(os.path.join(base_dir, dir_name)):
                files.append(os.path.join(dir_name, file_name))
        else:
            files.append(name)

    for file_name in files:
        source_file = os.path.join(base_dir, file_name)
        target_file = os.path.join(home_dir, file_name)
        link(source_file, target_file)


def link(source_file, target_file):
    if not os.path.lexists(source_file):
        return
    target_dir = os.path.dirname(target_file)
    if not os.path.exists(target_dir):
        os.makedirs(target_dir)
    elif os.path.lexists(target_file):
        if os.path.islink(target_file):
            os.unlink(target_file)
        else:
            bak = target_file + '.bak.' + datetime.datetime.now().isoformat()
            shutil.move(target_file, bak)
    os.symlink(os.path.relpath(source_file, start=target_dir), target_file)


if __name__ == '__main__':
    main()
