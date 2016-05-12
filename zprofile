# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# set LD_LIBRARY_PATH so it includes user's private lib if it exists
if [ -d "$HOME/.local/lib" ] ; then
    export LD_LIBRARY_PATH="$HOME/.local/lib:$LD_LIBRARY_PATH"
fi

# set PYTHONPATH so it includes user's private module if it exists
if [ -d "$HOME/.local/lib/python3.5/site-packages" ] ; then
    export PYTHONPATH="$HOME/.local/lib/python3.5/site-packages:$PYTHONPATH"
fi

# set steam env
export STEAM_FRAME_FORCE_CLOSE=1

