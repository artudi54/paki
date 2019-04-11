# Sets LINUX_SYSTEM and PACKAGER variables

if [ -f "/etc/debian_version" ]; then
    LINUX_SYSTEM="debian"
    if which apt 2>/dev/null 1>&2; then
        PACKAGER="apt"
        SUDO_PACKAGER="sudo apt"
    fi
elif [ -f "/etc/redhat-release" ]; then
    LINUX_SYSTEM="redhat"
    if which dnf 2>/dev/null 1>&2; then
        PACKAGER="sudo dnf"
        SUDO_PACKAGER="dnf"
    elif whitch yum 2>/dev/null 1>&2; then
        PACKAGER="yum"
        SUDO_PACKAGER="sudo yum"
    fi
elif [ -f "/etc/arch-release" ]; then
    LINUX_SYSTEM="arch"
    if which yay 2>/dev/null 1>&2; then
        PACKAGER="yay"
        SUDO_PACKAGER="yay"
    elif which yaourt 2>/dev/null 1>&2; then
        PACKAGER="yaourt"
        SUDO_PACKAGER="sudo yaourt"
    elif whitch pacman 2>/dev/null 1>&2; then
        PACKAGER="pacman"
        SUDO_PACKAGER="sudo pacman"
    fi
fi

if which snap 2>/dev/null 1>&2; then
    SNAP_PACKAGER="sudo snap"
fi

if which flatpak 2>/dev/null 1>&2; then
    FLATPAK_PACKAGER="sudo flatpak"
fi
