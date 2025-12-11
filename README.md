# Dotfiles

## 1. Install packages manually

- bitwarden
- steam
- brave-browser-bin
- ghostty (or if already, then set as terminal)
- hypruler-bin
- keychain
- stow
- syncthing
- tmux
- rose pine theme (with omarchy menu or this cli command: `omarchy-theme-install https://github.com/guilhermetk/omarchy-rose-pine-dark`)

## 2. Remove defaults
You will need to remove some of the default files in ~/.config subdirs, e.g:
```
~/.config/ghostty/
~/.config/hypr/
~/.config/nvim/
```

Stow will not override the existing files, so you must remove them yourself first.

## 3. Run scripts

There are two scripts to use, executable with `./clean-env` and `./stow-omarchy`. Do not use `./install` as it is called in `./stow-omarchy` already.
