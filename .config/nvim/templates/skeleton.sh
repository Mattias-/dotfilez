#!/bin/bash
set -euo pipefail

main() {
    if [ "$#" -le 0 ]; then
        help
        exit 1
    fi
    while [ "$#" -ge 1 ]; do
        case "$1" in
        --debug)
            shift
            set -x
            # shellcheck disable=2034
            DEBUG=true
            shift
            ;;
        #get)
        #    shift
        #    get "$@"
        #    break
        #    ;;
        help | *)
            shift
            help
            break
            ;;
        esac
    done
}

help() {
    cat <<EOF
Usage: $0 COMMAND
EOF
}

finish() {
    :
}
trap finish EXIT

echo_err_blue() {
    (
        tput setaf 033
        echo "$@"
        tput sgr0
    ) 1>&2
}

script_dir() {
    (cd "$(dirname "$(readlink -f "$0")")" && pwd)
}

main "$@"
