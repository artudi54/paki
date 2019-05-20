#!/bin/bash
DIRECTORY="$(dirname "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")")"
source "$DIRECTORY/util/configure.sh"
source "$DIRECTORY/util/util.sh"

if [ "$#" -ne 0 ]; then
    echo "paki: update-get command takes no arguments" 1>&2
    exit 1
fi

update-get-system() {
    case "$LINUX_SYSTEM" in
        debian)
            $SUDO_PACKAGER update 
            ;;
        redhat)
            $SUDO_PACKAGER makecache
            ;;
        arch)
            $SUDO_PACKAGER -Syy
            ;;
        *)
            echo "paki: invalid linux system variable settings" 1>&2
            return 3
    esac
}

validate-packager
update-get-system

