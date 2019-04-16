#!/bin/bash
DIRECTORY="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
source "$DIRECTORY/util/util.sh"

show-help() {
    echo "paki 1.0 (multiarch)"
    echo "Usage: paki <command> [args]"
    echo
    echo "paki is multiplatform package manager creating common"
    echo "intefrace for different linux distributions."
    echo "paki is using system package manager for it's operations."
    echo "It currently supports Debian, Arch Linux, Fedora and CentOS systems."
    echo
    echo "Supported commands:"
    echo "  install - install new packages"
    echo "  list - list installed packages"
    echo "  list-all - list all available packages"
    echo "  list-updates - list packages with available updates"
    echo "  reinstall - reinstall existing package or install new"
    echo "  remove - remove installed package"
    echo "  remove-unused - remove unused packages installed as dependencies"
    echo "  search - search for packages to install"
    echo "  update - update all installed packages"
    echo "  update-dist - perform full system update"
    echo "  update-get - get available updates"
    echo
    echo "Run 'paki --help <command>' for more information about specific command."
    echo
}


if [ "$#" -eq 0 ]; then
    show-help
    exit
fi

comm="$1"
shift
case "$comm" in
    --help)
        show-help
        ;;
    install)
        "$DIRECTORY/command/install.sh" "$@"
        ;;
    list)
        "$DIRECTORY/command/list.sh" "$@"
        ;;
    list-all)
        "$DIRECTORY/command/list-all.sh" "$@"
        ;;
    list-updates)
        "$DIRECTORY/command/list-updates.sh" "$@"
        ;;
    reinstall)
        "$DIRECTORY/command/reinstall.sh" "$@"
        ;;
    remove)
        "$DIRECTORY/command/remove.sh" "$@"
        ;;
    remove-unused)
        "$DIRECTORY/command/remove-unused.sh" "$@"
        ;;
    search)
        "$DIRECTORY/command/search.sh" "$@"
        ;;
    update)
        "$DIRECTORY/command/update.sh" "$@"
        ;;
    update-dist)
        "$DIRECTORY/command/update-dist.sh" "$@"
        ;;
    update-get)
        "$DIRECTORY/command/update-get.sh" "$@"
        ;;
    *)
        show-error-command "paki" "$comm"
esac

