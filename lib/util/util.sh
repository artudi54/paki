# This file contains utility functions

show-error-command() {
    echo "$1: invalid command: '$2'" 1>&2
    return 1
}

show-error-argument() {
    echo "$1: invalid argument: '$2'" 1>&2
    return 1
}

show-error-option() {
    echo "$1: invalid option: '$2'" 1>&2
    return 1
}

validate-packager() {
    if [ -z "$LINUX_SYSTEM" -o -z "$PACKAGER" ]; then
        echo "paki: could not find any suitable package manager in your PATH" 1>&2
        return 2
    fi
}

contains-help() {
    for str in $@; do
        if [ "$str" = "--help"]; then
            return 0
        fi
    done
    return 1
}
