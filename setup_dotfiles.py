#!/usr/bin/env python

import datetime
import os
import shutil

FILES = ['.bashrc', '.bash_profile', '.screenrc', '.gitignore_global',
         '.gitattributes_global', '.gitconfig', '.vim', '.functions', '.nvim']

DIRS = ['.ssh']

BASE_DIR = os.path.dirname(os.path.realpath(__file__))
HOME_DIR = os.path.expanduser('~')


def lin(rel_path, dest):
    if os.path.lexists(dest):
        if os.path.islink(dest):
            os.unlink(dest)
        else:
            bak = dest + '.bak.' + datetime.datetime.now().isoformat()
            shutil.move(dest, bak)
    os.symlink(rel_path, dest)


for file_name in FILES:
    rel_path = os.path.relpath(BASE_DIR + '/' + file_name, start=HOME_DIR)
    dest = HOME_DIR + '/' + file_name
    lin(rel_path, dest)

for d in DIRS:
    files = os.listdir(BASE_DIR + '/' + d)
    if not os.path.exists(HOME_DIR + '/' + d):
        os.makedirs(HOME_DIR + '/' + d)
    for file_name in files:
        rel_path = os.path.relpath(BASE_DIR + '/' + d + '/' + file_name,
                                   start=HOME_DIR + '/' + d)
        dest = HOME_DIR + '/' + d + '/' + file_name
        lin(rel_path, dest)
