#!/bin/bash

PLUGINS_DIR="/.config/tmux/plugins"
echo $HOME$PLUGINS_DIR

# Create plugins dir if it does not exist
if [ ! -d "$HOME$PLUGINS_DIR" ]; then
    echo "'$HOME$PLUGINS_DIR' does not exist, creating it..."
else
    echo "'$HOME$PLUGINS_DIR' aleady exists, skipping creation"
fi

# install plugins
if [ ! -d "$HOME$PLUGINS_DIR/tpm" ]; then
    echo "installing tpm"
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
else
    echo "tpm already installed"
fi
if  [ ! -d "$HOME$PLUGINS_DIR/tmux-sensible" ]; then
    echo "installing tmux-sensible"
    git clone https://github.com/tmux-plugins/tmux-sensible ~/.config/tmux/plugins/tmux-sensible
else
    echo "tmux-sensible already installed"
fi
if [ ! -d "$HOME$PLUGINS_DIR/tmux-cpu" ]; then
    echo "installing tmux-cpu"
    git clone https://github.com/tmux-plugins/tmux-cpu ~/.config/tmux/plugins/tmux-cpu 
else
    echo "tmux-cpu already installed"
fi
if [ ! -d "$HOME$PLUGINS_DIR/catppuccin/tmux" ]; then
    echo "installing catppucin"
    git clone latest@https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
else
    echo "catppuccin already installed"
fi

