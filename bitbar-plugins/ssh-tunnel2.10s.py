#!/usr/bin/env python

from __future__ import print_function
from collections import namedtuple
import os.path
import subprocess

Process = namedtuple('Process', ['pid', 'time', 'command'])
SSH_COMMAND = '/usr/bin/ssh -fN'
SSH_CONFIG_PATH = os.path.expanduser('~/.ssh/config')


def running_ssh_sessions():
    process = subprocess.Popen(['ps', '-eo', 'pid=,etime=,command='],
                               stdout=subprocess.PIPE)
    stdout, _ = process.communicate()
    res = []
    for line in stdout.splitlines():
        ps_process = Process(*line.split(None, 2))
        if ps_process.command.startswith(SSH_COMMAND):
            res.append(ps_process)
    return res


def ssh_config_hosts():
    config_options = [
        'localforward',
        'dynamicforward',
        'remoteforward',
    ]
    hosts = []
    with open(SSH_CONFIG_PATH, 'r') as ssh_config:
        for line in ssh_config:
            splitted = line.rstrip().split(None, 1)
            if len(splitted) < 2:
                continue
            key, value = splitted
            key = key.lower()
            if key == 'host':
                hosts.append({})
            hosts[-1][key] = value
    res = []
    for host in hosts:
        if '*' in host['host']:
            continue
        for option in config_options:
            if option in host:
                res.append(host['host'])
    return res


def main():
    running = running_ssh_sessions()
    conf_hosts = ssh_config_hosts()

    if len(running) > 0:
        print(':earth_americas:')
    else:
        print(':globe_with_meridians:')
    print('---')

    running_format = "{p.command} | color=green bash=/bin/kill param1='{p.pid}'  terminal=false refresh=true"
    for process in running:
        print(running_format.format(p=process))
        print('Connected time: %s' % process.time)
        print('---')

    for host in conf_hosts:
        print("{h} | bash=/usr/bin/ssh param1='-fN' param2={h} terminal=false refresh=true".format(h=host))

if __name__ == '__main__':
    main()
