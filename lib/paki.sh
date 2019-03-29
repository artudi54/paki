#!/bin/bash
DIRECTORY="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

show-help() {
    echo "paki 1.0 (multiarch)"
    echo "Usage: paki <command> [args]"
    echo
    echo "paki is multiplatform package manager creating common"
    echo "intefrace for different linux distributions."
    echo "paki is using system package manager for it's operations."
    echo
    echo "It currently supports Debian, Arch Linux, Fedora and CentOS systems."
    echo
    echo "Supported commands:"
    echo "  install - install new packages"
    echo "  list - list installed packages"
    echo "  reinstall - reinstall existing package or install new"
    echo "  remove - remove installed package"
    echo "  remove-unused - remove unused packages installed as dependencies"
    echo "  search - search for packages to install"
    echo "  update - update all installed packages"
    echo "  update-dist - perform full system update"
    echo "  update-get - get available updates"
    echo ""
    echo "Run 'paki <command> --help' for more information about specific command."
    echo ""
}

show-error() {
    echo "paki: invalid command: $1"
    return 1
}

if [ "$#" -eq 0 ]; then
    show-help
    exit
fi

comm="$1"
case "$comm" in
    --help)
        show-help
        exit
        ;;
    install)
        shift
        "$DIRECTORY/command/install.sh" "$@"
        exit
        ;;
    list)
        shift
        "$DIRECTORY/command/list.sh" "$@"
        exit
        ;;
    reinstall)
        shift
        "$DIRECTORY/command/reinstall.sh" "$@"
        exit
        ;;
    remove)
        shift
        "$DIRECTORY/command/remove.sh" "$@"
        exit
        ;;
    remove-unused)
        shift
        "$DIRECTORY/command/remove-unused.sh" "$@"
        exit
        ;;
    search)
        shift
        "$DIRECTORY/command/search.sh" "$@"
        exit
        ;;
    update)
        shift
        "$DIRECTORY/command/update.sh" "$@"
        exit
        ;;
    update-dist)
        shift
        "$DIRECTORY/command/update-dist.sh" "$@"
        exit
        ;;
    update-get)
        shift
        "$DIRECTORY/command/update-get.sh" "$@"
        exit
        ;;
    *)
        show-error "$1"
        exit
esac

