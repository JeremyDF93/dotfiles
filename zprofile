# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Rust's package manager private bin path
if [ -d "$HOME/.cargo/bin" ] ; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# set LD_LIBRARY_PATH so it includes user's private lib if it exists
if [ -d "$HOME/.local/lib" ] ; then
    export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"
fi

if [ -f "/usr/bin/ruby" ] ; then
    PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
    export GEM_HOME=$HOME/.gem
fi

#npm config set prefix ${HOME}/.local
export NPM_CONFIG_PREFIX="$HOME/.local"
