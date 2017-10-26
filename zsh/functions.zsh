#compdef y=yaourt
y() {
    yaourt "$@";
}

compdef p=pacman
p() {
    sudo pacman "$@";
}

fn() {
    local name="$1"
    shift
    find . -iname "*$name*" "$@"
}

gr() {
    grep -r "$@" .
}

lsvpk() {
    find . -type f -name "*_dir.vpk" -exec vpk l "{}" \;
}

#steam() {
#    LD_PRELOAD='/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1 /usr/$LIB/libgpg-error.so' /usr/bin/steam "$@"
#}

luna() {
    #curl -F "f=@$1" -F "l=1" https://luna.punked.us/
    scp -r "$@" jeremy@luna.punked.us:/home/jeremy/public/scp/

    for file in "$@"
    do
        echo "https://luna.punked.us/scp/$(basename $file)"
    done
}

dos2unix() {
    sed -i $'s/\r$//' "$@"
}

wine32() {
    WINEARCH=win32 WINEPREFIX=~/.wine32 wine "$@"
}

ssu() {
    sudo -u ${1:-root} -i
}

man() {
    env LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

