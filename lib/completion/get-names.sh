#!/bin/bash
DIRECTORY="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
source "$DIRECTORY/../util/configure.sh"
source "$DIRECTORY/../util/util.sh"

if [ "$#" -ne 1 ]; then
    echo "get-names.sh: invalid number of arguments" 1>&2
    exit 1
fi

print-system() {
    case "$LINUX_SYSTEM" in
        debian)
            apt-cache --no-generate pkgnames "$1"
            ;;
        redhat)
            ;;
        arch)
            ;;
        *)
            echo "paki: invalid linux system variable settings" 1>&2
            exit 3
    esac
}

print-snap() {
    grep "^$1" /var/cache/snapd/names
}

validate-packager
print-system "$1"
print-snap "$1"

