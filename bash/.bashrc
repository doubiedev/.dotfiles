# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'

alias v='nvim'
alias la='ls -la'

# Keychain
/usr/bin/keychain --quiet $HOME/.ssh/id_ed25519
source $HOME/.keychain/$HOSTNAME-sh
