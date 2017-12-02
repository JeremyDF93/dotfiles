# auto completion
autoload -Uz compinit && compinit

setopt completeinword
setopt histverify

# Tab completion should be case-insensitive.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# pure
fpath+=('/home/jeremy/.local/lib/node_modules/pure-prompt/functions')

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS

export VISUAL="vim"
export TERM="xterm-256color"

bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
