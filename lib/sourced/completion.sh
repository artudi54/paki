# Completion functions for paki command

# Utils
_paki_yes() {
    if [ "${COMP_WORDS[-1]:0:2}" = "--" ]; then
        COMPREPLY=($(compgen -W "--yes" -- "${COMP_WORDS[-1]}"))
    elif [ "${COMP_WORDS[-1]:0:1}" = "-" ]; then
        COMPREPLY=($(compgen -W "-y" -- "${COMP_WORDS[-1]}"))
    fi
}

_paki_switch() {
    case "${COMP_WORDS[1]}" in
        "update")
            _paki_update;;
        "update-dist")
            _paki_update-dist;;
        "update-get")
            _paki_update-get;;
    esac
}

# Command completes
_paki_update() {
    _paki_yes
}

_paki_update-dist() {
    _paki_yes
}

_paki_update-get() {
}

# Main complete
_paki() {
    if [ "$COMP_CWORD" -ne 1 ]; then
        _paki_switch
        return
    fi

    if [ "${COMP_WORDS[1]:0:1}" = "-" ]; then
        COMPREPLY=($(compgen -W "--help" -- "${COMP_WORDS[1]}"))
    else
        local commands
        commands="install list list-all list-updates reinstall remove remove-unused search update update-dist update-get"
        COMPREPLY=($(compgen -W "$commands" -- "${COMP_WORDS[1]}"))
    fi
}

complete -F _paki paki
