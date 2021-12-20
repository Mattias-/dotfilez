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
    if [[ "$OSTYPE" == "linux"* ]]; then
        (cd "$(dirname "$(readlink -f "$0")")" && pwd)
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        (cd "$(dirname "$(readlink "$0")")" && pwd)
    fi
}

main "$@"
