# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$HOME/.gem/ruby/2.0.0/bin:$PATH"
fi

# set LD_LIBRARY_PATH so it includes user's private lib if it exists
if [ -d "$HOME/.local/lib" ] ; then
    export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"
fi

<<<<<<< HEAD
# set PYTHONPATH so it includes user's private module if it exists
if [ -d "$HOME/.local/lib/python3.5/site-packages" ] ; then
    export PYTHONPATH="$HOME/.local/lib/python3.5/site-packages:$PYTHONPATH"
fi
=======
#npm config set prefix ${HOME}/.local
export NPM_CONFIG_PREFIX="$HOME/.local"
>>>>>>> af62bc6... [zsh] use pure prompt

# set steam env
export STEAM_FRAME_FORCE_CLOSE=1

<<<<<<< HEAD
=======
#fix kwin shit
export KWIN_TRIPLE_BUFFER=1
>>>>>>> af62bc6... [zsh] use pure prompt
