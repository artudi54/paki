# This file contains utility functions

contains-help() {
    for str in $@; do
        if [ "$str" = "--help"]; then
            return 0
        fi
    done
    return 1
}
