#!/usr/bin/env bash
# godot-open.sh
# Usage: godot-open.sh FILE LINE COL

FILE="$1"
LINE="${2:-1}"
COL="${3:-1}"

# Convert Windows path to WSL path
WSL_FILE=$(wslpath "$FILE")

# Send to running Neovim server
/home/nd/.dotfiles/bin/.local/bin/nvim/bin/nvim --server 127.0.0.1:6004 --remote-send "<esc>:n $WSL_FILE<CR>:call cursor($LINE,$COL)<CR>"
