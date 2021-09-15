#!/bin/bash
set -euo pipefail

case $(uname | tr '[:upper:]' '[:lower:]') in
linux*)
    DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
    ;;
*)
    DIR="$(cd "$(dirname "$(readlink "$0")")" && pwd)"
    ;;
esac

if [[ "$OSTYPE" == "linux"* ]]; then
    VM_DRIVER="virtualbox"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    VM_DRIVER="hyperkit"
fi

main() {
    :
}

finish() {
    :
}
trap finish EXIT

echo_err_blue() {
    tput setaf 033
    echo 1>&2 "$@"
    tput sgr0
}

main "$@"
