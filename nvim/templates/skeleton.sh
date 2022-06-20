#!/bin/bash
set -euo pipefail

main() {
    :
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
