# Completion functions for paki command

_paki_switch() {
    return
}
_paki() {
    if [ "$COMP_CWORD" -ne 1 ]; then
        _paki_switch
        return
    fi

    if [ "${COMP_WORDS[1]:0:1}" = "-" ]; then
        echo yes
        COMPREPLY=($(compgen -W "--help" -- "${COMP_WORDS[1]}"))
    else
        local commands
        commands="install list list-all list-updates reinstall remove remove-unused search update update-dist update-get"
        COMPREPLY=($(compgen -W "$commands" -- "${COMP_WORDS[1]}"))
    fi
}

complete -F _paki paki
