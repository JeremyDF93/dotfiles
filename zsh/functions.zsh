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

colors() {
  T='gYw'   # The test text

  echo -e "\n                 40m     41m     42m     43m     44m     45m     46m     47m";

  for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
             '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
             '  36m' '1;36m' '  37m' '1;37m';
    do FG=${FGs// /}
    echo -en " $FGs \033[$FG  $T  "
    for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
      do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
    done
    echo;
  done
  echo
}
