#!/bin/bash

# Ensure fzf is installed
if ! command -v fzf &> /dev/null; then
    echo "'fzf' is required but not installed."
    read -rp "Would you like to install 'fzf' now? (y/n): " install_fzf
    if [[ "$install_fzf" =~ ^[Yy]$ ]]; then
        sudo apt update
        sudo apt install -y fzf
    else
        echo "Cannot continue without fzf. Exiting."
        exit 1
    fi
fi

# Define packages (just a flat list)
PACKAGES=(
    # Initial Utilities
    curl
    git
    htop
    stow
    vlc
    keychain
    rofi
    unzip
    # i3
    i3
    brightnessctl
    redshift
    blueman
    pavucontrol
    pasystray
    nitrogen
    maim
    xclip
    mpv
    autorandr
    arandr
    # i3/gnome
    dconf-editor
    gnome-tweaks
    gtk-chtheme
    lxappearance
    # nvim
    vim
    ripgrep
    gcc
    # tmux
    tmux
    fzf
)

# Prompt for install mode
echo "Choose installation option:"
echo "1) Install ALL packages"
echo "2) Choose packages interactively (fzf)"
read -rp "Enter 1 or 2: " choice

SELECTED_PACKAGES=()

if [[ "$choice" == "1" ]]; then
    SELECTED_PACKAGES=("${PACKAGES[@]}")
elif [[ "$choice" == "2" ]]; then
    # Use fzf to select packages
    SELECTED_PACKAGES=($(printf "%s\n" "${PACKAGES[@]}" | fzf --multi --prompt="Select packages (Use TAB to add multiple) > " --preview="apt show {} 2>/dev/null | head -20" --height=90% --border --reverse))

    if [[ ${#SELECTED_PACKAGES[@]} -eq 0 ]]; then
        echo "No packages selected. Exiting."
        exit 0
    fi
else
    echo "Invalid option. Exiting."
    exit 1
fi

# Confirm
echo -e "\nThe following packages will be installed:"
printf ' - %s\n' "${SELECTED_PACKAGES[@]}"

read -rp "Proceed with installation? (y/n): " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
    sudo apt update
    sudo apt install -y "${SELECTED_PACKAGES[@]}"
    echo "Installation complete."
else
    echo "Cancelled."
    exit 0
fi

