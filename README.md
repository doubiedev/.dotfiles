# .dotfiles

My dotfiles.


## Installation
1. Clone repo to `~/.dotfiles`
2. Run ./install-packages.sh
3. Manually install packages according to [[#Manual packages installation]]
4. Copy and modify appropriate `.bashrc` from `~/.dotfiles/manual` to `~/.bashrc`
5. Run ./ubuntu


## Manual packages installation
---
### Packages with external (or not in this readme) installation instructions
- brave-browser
- zen browser
- [ghostty](https://github.com/mkasberg/ghostty-ubuntu)
- syncthing
    - playlists (syncthing)
- obsidian
- todoist
- splatmoji
- appimagelauncher
- tlp

### Tmux tpm and plugins
1. Clone TPM:
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

2. Reload TMUX environment to TPM is sourced:
```bash
tmux source ~/.tmux.conf
```

3. Press `prefix` + `I` (capital i) to fetch plugins according to `~/.tmux.conf`


### Stow (>= 2.4.0)
```bash
sudo su
cd ~
wget https://github.com/aspiers/stow/archive/refs/tags/v2.4.0.tar.gz
tar -xvzf ./v2.4.0.tar.gz
cd ./stow-2.4.0
apt install autoreconf make texinfo texlive -y
autoreconf -iv
cpan # or perl -MCPAN -e shell
# yes
# sudo
# install Test::Output
# install Test::More
# q
touch ChangeLog
./configure && make install
# eval `perl -V:siteprefix`
# ./configure --prefix=$siteprefix && make
rm -rf ~/v2.4.0.tar.gz
rm -rf ~/stow-2.4.0
```


### Starship
```bash
curl -sS https://starship.rs/install.sh | sh
```


### Lazygit
For **Ubuntu 25.04 "Plucky Puffin"** and earlier:
```bash
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
```

# FOR NVIM GODOT
Editor settings:
Language Server Remote Host: 0.0.0.0

External editor:
Exec Path = C:/Users/nd/scripts/nvim.cmd
Exec Flags = {file} {line} {col}

ALWAYS OPEN NVIM WITH `nvim --listen /tmp/godot.pipe`
Have a .bashrc alias for gv

### nvim.cmd
@echo off
wsl wslpath "%1" > tmpfile
set /p filepath= < tmpfile
del tmpfile
wsl nvim --server "/tmp/godot.pipe" --remote-send "<esc>:n %filepath%<CR>:call cursor(%2,%3)<CR>"

