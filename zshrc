# settings
source ~/.zsh/settings.zsh

# aliases
source ~/.zsh/aliases.zsh

# functions
source ~/.zsh/functions.zsh

# prompt
source ~/.zsh/prompt.zsh

source ~/.zsh/key-bindings.zsh

# fortune
#if [ -x /usr/bin/fortune ] ; then
#    echo
#    fortune -s | ponysay --balloon unicode --wrap 120
#    echo
#fi

motd() {
  ip="$(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')"
  ip6="$(ip addr show dev eno1 | sed -e's/^.*inet6 \([^ ]*\)\/.*$/\1/;t;d')"
  up=$(uptime | cut -d ' ' -f 4-5 | sed 's/,//g' | sed 's/d/D/g')
  user=$(uptime | cut -d ' ' -f 8-9 | \grep -o "[0-9]")
  disk=$( df -h | \grep nvme0n1p2 | \grep -o "[0-9]*%" )
  ram=$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')
  cpu=$( uptime | cut -d ' ' -f 15 | sed 's/,//g' | awk '{CONVFMT = "%2.1f"; load = $1 * 100 / 8; print load"%" }')

  echo -e "\e[38;5;63m
         .......
         ;;;;;;;;;;;;....
          .;;;;;;;;;;;;;;;..          \e[38;5;255mWelcome\e[38;5;63m
         .;;;;;;;;;;;;;;;;;;;;.         
         .;;;;;;;;;;;;;.\e[38;5;255m++++\e[38;5;63m-;;;.           \e[38;5;231m .....   ...\e[38;5;63m
          .;;;;;;;;;;;;;;.\e[38;5;255m+++++\e[38;5;63m-;.          \e[38;5;231m:     ';'--' \e[38;5;63m
           .;;;;;;;;;;;;;;\e[38;5;255m++++++\e[38;5;63m;;.         \e[38;5;111m'..   # \e[38;5;63m
  .;;;.      -;;;;;\e[38;5;255m+\e[38;5;63m;;;;;.\e[38;5;255m++++++\e[38;5;63m;;;\e[38;5;105m              ##\e[38;5;63m
 .;;;;;.      ;;;;;\e[38;5;255m++\e[38;5;63m;;;\e[38;5;255m++++++++\e[38;5;63m;;;.\e[38;5;105m             ##\e[38;5;63m
 .;;;;;.     ;;;;;;.\e[38;5;255m+++++++++++\e[38;5;63m;;;;;\e[38;5;105m             ##                            \e[38;5;63m
  ';;;'     ;;;;;;;;.\e[38;5;255m++++++++++\e[38;5;63m.;;;;;\e[38;5;69m            ##                ##    ##    #######      ### \e[38;5;63m
            -;;;;;;;;;\e[38;5;255m+++++++\e[38;5;63m.;;;;;;;\e[38;5;69m            #     ;'''';.     #     #     #     ##        #\e[38;5;63m
             ;;;;;;;;;;;;;;;;;;;;;;;;\e[38;5;69m           ;#    ;.     #    ##    ##    ##    ##    #####\e[38;5;63m
              -;;;;;;;-  -;;;;;;;;;;;   .....   #      '     ##   #     #     #     #    #    #  
                 '''        ;;;;;;;;;  #    ';.##..        ..#    #######    ##    ##     ####          
                     .;;.   ;;;;;;;;;  '####'      '#####''
                    ;;;;;;  -;;;;;;;;     
                     ';;'-     ;;;;;; 
                               ''''  \e[38;5;33mIP: $ip   \e[38;5;39mUptime: $up  \e[38;5;45mDisk Used: $disk    \e[38;5;51mCPU Load: $cpu \e[38;5;63m
                        \e[38;5;33mIPv6: $ip6   \e[38;5;39mUsers: $user        \e[38;5;45mRAM Used: $ram \e[38;5;51m
  "
}
#motd

