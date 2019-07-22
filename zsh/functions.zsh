compdef y=yay
y() {
    yay "$@";
}

compdef p=pacman
p() {
    sudo pacman "$@";
}

popt() {
    p -S --needed --asdeps $(expac -S '%o' "$@")
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
    scp -r "$@" jeremy@praisethemoon.com:/home/jeremy/apps/praisethemoon/public/scp/

    for file in "$@"
    do
        str="${$(basename $file)// /%20}"
        echo "https://praisethemoon.com/scp/${str}"
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

rightPad() {
  padding=$1
  shift
  str="$*"
  pad=$(( $padding - ${#str} ))
  printf "%s%${pad}s" "$str" ""
}

formatBytes() {
  bytes="$1"
  padding=$2
  [ ! -z "$padding" ] || padding=0

  num=$(( $1 + 0 ))
  div=1
  units=""
  if [ $num -gt $(( 1024 ** 3 )) ]; then
    div=$(( 1024 ** 3 ))
    units="GiB"
  elif [ $num -gt $(( 1024 * 1024 )) ]; then
    div=$(( 1024 * 1024 ))
    units="MiB"
  elif [ $num -gt $(( 1024 )) ]; then
    div=1024
    units="KiB"
  fi

  if [ -z "$units" ]; then
    ret="$num"B
  else
    ret=$(( ( num * 100 ) / div ))
    ind=$(( ${#ret} - 2 ))
    ret="${ret:0:$ind}.${ret:$ind}${units}"
  fi

  echo -n "$ret"
  pad=$(( $padding - ${#ret} ))
  if [ $pad -gt 0 ]; then
    printf "%${pad}s" " "
  fi
  echo
}

# Tries to connect to keychain, invalidates SSH_AGENT vars if it cannot.
try_keychain() {
  keyfile="$HOME/.keychain/$HOSTNAME-sh"
  [ ! -f "$keyfile" ] || source "$keyfile"
  if [ -z "$SSH_AUTH_SOCK" ] || \
     [ -z "$SSH_AGENT_PID" ] || \
     [ ! -e "$SSH_AUTH_SOCK" ] || \
     [ -z "$(ps -p "$SSH_AGENT_PID" -o comm=)" ]; then
    unset SSH_AUTH_SOCK
    unset SSH_AGENT_PID
    return 1
  fi
  return 0
}

sh_c()
{
  if [[ $- == *i* ]] ; then
    #[ ! -z "$NEPH_COLOR_TERM" ] || return
    local c="$1"
    local b="$2"
    [ ! -z "$c" ] || c=0
    [ ! -z "$b" ] || [ $c -eq 0 ] || b=0
    [ -z "$b" ] || b="$b;"
    echo -n -e "\e[$b${c}m"
  fi
}

estat()   { echo >&2 "$(sh_c 32 1)::$(sh_c) $*"; }
estat2()  { echo >&2 "  $(sh_c 34 1)->$(sh_c) $*"; }
emsg()    { echo >&2 "$(sh_c 34 1)::$(sh_c) $*"; }
emsg2()   { echo >&2 "  $(sh_c 34 1)->$(sh_c) $*"; }
ewarn()   { echo >&2 "$(sh_c 33 1);;$(sh_c) $*"; }
ewarn2()  { echo >&2 "  $(sh_c 33 1)=>$(sh_c) $*"; }
einfo()   { echo >&2 "$(sh_c 30 1)::$(sh_c) $*"; }
einfo2()  { echo >&2 "  $(sh_c 30 1)->$(sh_c) $*"; }
eerr()    { echo >&2 "$(sh_c 31 1)!!$(sh_c) $*"; }
eerr2()   { echo >&2 "  $(sh_c 31 1)~>$(sh_c) $*"; }
eerrint() { eerr "$@"; return 1; }

# Shows "+ command" as stderr, info style
showcmd() { echo >&2 "$(sh_c 30 1)+$(sh_c) $(sh_quote "$@")"; }
# Shows "`#` command" as stdout, copy-pasteable by user (`#` is a bash no-op)
offercmd() { echo "$(sh_c 30 1)\`#\`$(sh_c) $(sh_quote "$@")"; }
# showcmd and also actually run it
cmd() { showcmd "$@"; "$@"; }
# showcmd and actually run it, with stderr to /dev/null. This is helpful since
#   showcmd echos to stderr, so $(cmd 2>/dev/null ...) is self-defeating
scmd() { showcmd "$@"; "$@" 2>/dev/null; }
# showcmd and actually run it, with stdout to /dev/null
qcmd() { showcmd "$@"; "$@" >/dev/null; }
# showcmd and actually run it, with all output to /dev/null
xcmd() { showcmd "$@"; "$@" &>/dev/null; }

die() { eerr "$*"; exit 1; }

# Tries to find the running session for this user and steals its
# DISPLAY/XAUTHORITY env
get_x_session()
{
  pid=$(pgrep -o -u $USER gnome-session || true)
  [ -z "$pid" ] && pid=$(pgrep -o -u $USER xfce4-session || true)
  [ -z "$pid" ] && pid=$(pgrep -o -u $USER kded4 || true)
  if [ ! -z "$pid" ]; then
    echo >&2 ":: Stealing env from $pid"
    export $(cat /proc/$pid/environ | grep -z XAUTHORITY)
    export $(cat /proc/$pid/environ | grep -z DISPLAY)
  else
      export XAUTHORITY=$HOME/.Xauthority
  fi
  [ ! -z "$DISPLAY" ] || export DISPLAY=:0
  [ ! -z "$XAUTHORITY" ] || export XAUTHORITY=$HOME/.Xauthority
}

sh_is_callable_thing()
{
  if [[ $# -ne 1 ]]; then
    eerr "Internal error: sh_is_callable_thing takes exactly 1 argument"
    return 1
  fi

  local cmd="$1"
  case "$([[ -z $cmd ]] || type -t "$cmd" || true)" in
    "function" |\
    "builtin" |\
    "alias" |\
    "file")
      return 0
    ;;
    *)
      return 1
    ;;
  esac
}

require_commands()
{
  if [[ $# -lt 2 ]]; then
    eerr "Internal error: require_commands mis-used, requires at least two arguments"
    return 1
  fi

  local script="$1"
  shift
  local cmd
  while [[ $# -gt 0 ]]; do
    cmd="$1"
    shift
    if ! sh_is_callable_thing "$cmd"; then
      eerr "'$cmd' utility not found, required by '$script'"
      return 1
    fi
  done
  return 0
}

sh_quote()
{
  local args=()
  for arg in "$@"; do
    args[${#args[@]}]="$(printf '%q' "$arg")"
  done
  echo "${args[@]}"
}

# Prints eval-able expression to set given variable, e.g.:
# sh_var DISPLAY -> "DISPLAY=':0'"
# FIXME Behavior is undefined for invalid variable name input
sh_var()
{
  echo "$(sh_quote "$1")"="$(sh_quote "${!1}")"
}

parse_args()
{
  if [ "$#" -lt 3 ]; then
    eerr "Internal error: incorrect usage of parse_args"
  fi
  [ "$#" -gt 3 ] || return 0

  local app_name="$1"
  local short_opts="$2"
  local long_opts="$3"

  shift; shift; shift

  _parse_args_options=()
  _parse_args_values=()
  _parse_args_args=()
  local parsed

  if ! parsed="$(getopt -n "$app_name" -o "$short_opts" -l "$long_opts" -- "$@")"; then
    return 1
  fi
  eval parsed=("$parsed")
  local i=0
  while [ $i -lt ${#parsed[@]} ]; do
    local arg="${parsed[$i]}"
    local opt
    local val
    (( ++i ))
    if [ ${#arg} -lt 2 ] || [ "${arg:0:1}" != "-" ]; then
      eerr "Internal error: Unexpected arg \"$arg\" while parsing getopt output"
      continue
    fi
    if [ "$arg" = "--" ]; then # end of options
      _parse_args_args=("${parsed[@]:$i}")
      break
    elif [ "${arg:1:1}" = "-" ]; then # long opt
      local opt_name="${arg:2}"
      local IFS=","
      for x in ${long_opts}; do
        if [ "${x:$(( ${#x} - 1 ))}" = ":" ] &&
           [ "${x:0:$(( ${#x} - 1 ))}" = "$opt_name" ]; then
          # arg long opt
          opt="$opt_name"
          val="${parsed[$i]}"
          (( ++i ))
          opt_name=""
          continue
        elif [ "$x" = "$opt_name" ]; then
          # boolean long opt
          opt="$opt_name"
          val=1
          opt_name=""
          continue
        fi
      done
      if [ ! -z "$opt_name" ]; then
        eerr "Internal error: Failed to find opt \"$opt_name\""
      fi
    elif [ ${#arg} -eq 2 ]; then # short opt
      local shorts="$short_opts"
      while [ ! -z "$shorts" ] && [ "${shorts:0:1}" != "${arg:1:1}" ]; do
        shorts="${shorts:1}"
      done
      if [ -z "$shorts" ]; then
        eerr "Internal error: Unfound short option $arg"
      else
        if [ "${shorts:1:1}" = ":" ]; then
          # arg short opt
          opt="${arg:1:1}"
          val="${parsed[$i]}"
          (( ++i ))
        else
          # bool short opt
          opt="${arg:1:1}"
          val=1
        fi
      fi
    fi
    _parse_args_options[${#_parse_args_options[@]}]="$opt"
    _parse_args_values[${#_parse_args_values[@]}]="$val"
  done
}

# get_merged_option option_one [option_two ...]
#   For aliased options, e.g. -h and --help, gets first set value (pass options
#   in descending precedence)
get_merged_option()
{
  local opt_name
  local i=0
  while [ $i -lt ${#_parse_args_options[@]} ]; do
    for opt_name in "$@"; do
      if [ "${_parse_args_options[$i]}" = "$opt_name" ]; then
        echo "${_parse_args_values[$i]}"
        return
      fi
    done
    (( ++i ))
  done
}

get_option()
{
  local opt_name="$1"
  local default="$2"
  local i=0
  while [ $i -lt ${#_parse_args_options[@]} ]; do
    if [ "${_parse_args_options[$i]}" = "$opt_name" ]; then
      echo "${_parse_args_values[$i]}"
      return
    fi
    (( ++i ))
  done
  echo "$default"
}

# Differentiate between empty option and not passed
has_option()
{
  local opt_name="$1"
  local opt
  for opt in ${_parse_args_options[@]}; do
    [[ $opt != $opt_name ]] || return 0
  done
  # Not found
  return 1
}

get_arg()
{
  # Args are 1-indexed, though we don't keep $0 around
  local i=$(($1 - 1))
  echo "${_parse_args_args[$i]}"
}

num_args()
{
  echo "${#_parse_args_args[@]}"
}

get_args()
{
  sh_quote "${_parse_args_args[@]}"
}
