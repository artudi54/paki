# Completion functions for paki command

# Utils
_paki_yes() {
    if [ "${COMP_WORDS[-1]:0:2}" = "--" ]; then
        COMPREPLY+=($(compgen -W "--yes" -- "${COMP_WORDS[-1]}"))
    elif [ "${COMP_WORDS[-1]:0:1}" = "-" ]; then
        COMPREPLY+=($(compgen -W "-y" -- "${COMP_WORDS[-1]}"))
    fi
}

_paki_generate() {
    "$_paki_completion_dir/get-names.sh" "$@" 2>/dev/null
}

_paki_switch() {
    case "${COMP_WORDS[1]}" in
        "install")
            _paki_install;;
        "reinstall")
            _paki_reinstall;;
        "update")
            _paki_update;;
        "update-dist")
            _paki_update-dist;;
        "update-get")
            _paki_update-get;;
    esac
}

#Command completes
_paki_install() {
    local DIRECTORY
    DIRECTORY="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
    COMPREPLY=($(compgen -W "$(_paki_generate "${COMP_WORDS[-1]}")" "${COMP_WORDS[-1]}"))
}
_paki_reinstall() {
    _paki_install
}
_paki_update() {
    _paki_yes
    if [ "${COMP_WORDS[-1]:0:2}" = "--" ]; then
        COMPREPLY+=($(compgen -W "--system --snap --flatpak" -- "${COMP_WORDS[-1]}"))
    elif [ "${COMP_WORDS[-1]:0:1}" = "-" ]; then
        COMPREPLY+=($(compgen -W "-s -S -f" -- "${COMP_WORDS[-1]}"))
    fi
}

_paki_update-dist() {
    _paki_update
}

_paki_update-get() {
 :;
}

# Main complete
_paki() {
    COMPREPLY=()
    if [ "$COMP_CWORD" -ne 1 ]; then
        _paki_switch
        return
    fi

    if [ "${COMP_WORDS[1]:0:1}" = "-" ]; then
        COMPREPLY+=($(compgen -W "--help" -- "${COMP_WORDS[1]}"))
    else
        local commands
        commands="install list list-all list-updates reinstall remove remove-unused search update update-dist update-get"
        COMPREPLY+=($(compgen -W "$commands" -- "${COMP_WORDS[1]}"))
    fi
}


echo "path: ${BASH_SOURCE[@]}"
_paki_completion_dir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
complete -F _paki paki

