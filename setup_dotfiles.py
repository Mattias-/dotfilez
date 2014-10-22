#!/usr/bin/env python

import datetime
import os
import sys
import shutil

FILES = ['.bashrc',
        '.bash_profile',
        '.screenrc',
        '.gitignore_global',
        '.gitconfig',
        '.vim']

DIRS = ['.ssh',
        'bin']

base_dir = os.path.dirname(os.path.realpath(__file__))
home_dir = os.path.expanduser('~')

def lin(rel_path, dest):
    if os.path.exists(dest):
        if os.path.islink(dest):
            os.unlink(dest)
        else:
            bak = dest + '.bak.' + datetime.datetime.now().isoformat()
            shutil.move(dest, bak)
    os.symlink(rel_path, dest)

for file in FILES:
    rel_path = os.path.relpath(base_dir + '/' + file)
    dest = home_dir + '/' + file
    lin(rel_path, dest)

for d in DIRS:
    files = os.listdir(base_dir + '/' + d)
    if not os.path.exists(home_dir + '/' + d):
            os.makedirs(home_dir + '/' + d)
    for file in files:
        rel_path = os.path.relpath(base_dir + '/' + d + '/' + file, start=home_dir+'/'+d)
        dest = home_dir + '/' + d + '/' + file
        lin(rel_path, dest)



