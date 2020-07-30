# auto completion
fpath+=("$HOME/.local/lib/node_modules/pure-prompt/functions")
fpath+=("$HOME/.local/share/zsh/site-functions")
fpath+=("$HOME/.zsh/site-functions/zsh-completions/src")

plugins=(… zsh-completions)
autoload -Uz compinit && compinit

setopt completeinword
setopt histverify

# Tab completion should be case-insensitive.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt COMPLETE_ALIASES

export VISUAL="vim"
export TERM="xterm-256color"

bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
