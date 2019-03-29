# Sets LINUX_SYSTEM and PACKAGER variables

if [ -f "/etc/debian_version" ]; then
    LINUX_SYSTEM="debian"
    if which apt 2>/dev/null 1>&2; then
        PACKAGER="sudo apt"
    fi
elif [ -f "/etc/redhat-release" ]; then
    LINUX_SYSTEM="redhat"
    if which dnf 2>/dev/null 1>&2; then
        PACKAGER="sudo dnf"
    elif whitch yum 2>/dev/null 1>&2; then
        PACKAGER="sudo yum"
    fi
elif [ -f "/etc/arch-release" ]; then
    LINUX_SYSTEM="arch"
    if which yay 2>/dev/null 1>&2; then
        PACKAGER="yay"
    elif which yaourt 2>/dev/null 1>&2; then
        PACKAGER="yaourt"
    elif whitch pacman 2>/dev/null 1>&2; then
        PACKAGER="sudo pacman"
    fi
fi
