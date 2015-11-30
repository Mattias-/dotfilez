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
]

DIRS = ['.ssh', '.config']

def main():
    BASE_DIR = os.path.dirname(os.path.realpath(__file__))
    HOME_DIR = os.path.expanduser('~')

    for file_name in FILES:
        source_dir = BASE_DIR
        target_dir = HOME_DIR
        link(source_dir, target_dir, file_name)

    for d in DIRS:
        source_dir = os.path.join(BASE_DIR, d)
        target_dir = os.path.join(HOME_DIR, d)
        for file_name in os.listdir(source_dir):
            link(source_dir, target_dir, file_name)


def link(source_dir, target_dir, file_name):
    source_file = os.path.join(source_dir, file_name)
    target_file = os.path.join(target_dir, file_name)
    if not os.path.exists(target_dir):
        os.makedirs(target_dir)
    elif os.path.lexists(target_file):
        if os.path.islink(target_file):
            os.unlink(target_file)
        else:
            bak = target_file + '.bak.' + datetime.datetime.now().isoformat()
            shutil.move(target_file, bak)
    os.symlink(os.path.relpath(source_file, start=target_dir), target_file)


if __file__ == '__main__':
    main()
