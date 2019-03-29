#!/bin/bash
DIRECTORY="$(dirname "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")")"
source "$DIRECTORY/util/configure.sh"
source "$DIRECTORY/util/util.sh"

if [ -z "$LINUX_SYSTEM" -o -z "$PACKAGER" ]; then
    echo "paki: could not find any suitable package manager in your PATH" 1>&2
    exit 2
fi

case "$LINUX_SYSTEM" in
    debian)
        $PACKAGER remove "$@" 
        ;;
    redhat)
        $PACKAGER remove "$@"
        ;;
    arch)
        $PACKAGER -R "$@"
        ;;
    *)
        echo "paki: invalid linux system variable settings" 1>&2
        exit 3
esac

