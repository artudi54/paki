#!/bin/bash
DIRECTORY="$(dirname "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")")"
source "$DIRECTORY/util/configure.sh"
source "$DIRECTORY/util/util.sh"

nocheck=0
system=0
snap=0
flatpak=0

parse-args() {
    for arg in "$@"; do
        shift
        case "$arg" in
            --yes)
                set -- "$@" "-y" 
                ;;
            --system)
                set -- "$@" "-s" 
                ;;
            --snap)
                set -- "$@" "-S" 
                ;;
            --flatpak)
                set -- "$@" "-f" 
                ;;
            *)
                set -- "$@" "$arg"
        esac
    done

    OPTIND=1
    OPTERR=0
    while getopts ":ysSf" opt; do
        case "$opt" in
            "y")
                nocheck=1
                ;;
            "s")
                system=1
                ;;
            "S")
                snap=1
                ;;
            "f")
                flatpak=1
                ;;
            *)
                show-error-option "paki update" "-$OPTARG"
        esac
    done
    if [ "$OPTIND" -le "$#" ]; then
        show-error-argument "paki update" "${!OPTIND}"
    fi

    if [ -z "$LINUX_SYSTEM" -o -z "$PACKAGER" ]; then
        echo "paki: could not find any suitable package manager in your PATH" 1>&2
        return 2
    fi
}

update-system() {
    case "$LINUX_SYSTEM" in
        debian)
            if [ "$nocheck" -eq 1 ]; then
                $SUDO_PACKAGER update && $SUDO_PACKAGER upgrade -y 
            else
                $SUDO_PACKAGER update && $SUDO_PACKAGER upgrade 
            fi
            ;;
        redhat)
            if [ "$nocheck" -eq 1 ]; then
                $SUDO_PACKAGER update -y
            else
                $SUDO_PACKAGER update
            fi
            ;;
        arch)
            if [ "$nocheck" -eq 1 ]; then
                $SUDO_PACKAGER -Syu --noconfirm
            else
                $SUDO_PACKAGER -Syu
            fi
            ;;
        *)
            echo "paki: invalid linux system variable settings" 1>&2
            return 3
    esac
}

update-snap() {
    if [ ! -z "$SNAP_PACKAGER" ]; then
        $SNAP_PACKAGER refresh
    fi
}

update-flatpak() {
    if [ ! -z "$FLATPAK_PACKAGER" ]; then
        if [ "$nocheck" -eq 1 ]; then
            $FLATPAK_PACKAGER update -y
        else
            $FLATPAK_PACKAGER update
        fi
    fi
}

validate-packager
parse-args "$@"
if [ "$system" -eq 0 -a "$snap" -eq 0 -a "$flatpak" -eq 0 ]; then
    update-system
    update-snap
    update-flatpak
elif [ "$system" -eq 1 ]; then
    update-system
elif [ "$snap" -eq 1 ]; then
    update-snap
elif [ "$flatpak" -eq 1 ]; then
    update-flatpak
fi

