# Dotfiles

Personal configs managed with [GNU stow](https://www.gnu.org/software/stow/).
Each directory at the top level is a *stow package*: its internal paths mirror your
`$HOME`, and `stow <package>` creates symlinks in your home directory pointing at the
files in this repo. Editing the file (either through the symlink or in the repo) updates
the same file.

## Packages

| Package | Symlinks into | What it manages |
|---------|---------------|-----------------|
| `bash` | `~/.bashrc` | Shell configuration |
| `bin` | `~/.local/bin/` | Personal CLI tools on `PATH` (`cht.sh`, `codex`, `opencode`, tmux helpers, …) |
| `ghostty` | `~/.config/ghostty/` | Ghostty terminal |
| `hooks` | `~/.config/omarchy/hooks/` | Omarchy automation hooks (see below) |
| `hyprland` | `~/.config/hypr/` | Hyprland (see *Hyprland layout* below) |
| `nvim` | `~/.config/nvim/` | Neovim config + plugins |
| `starship` | `~/.config/starship.toml` | Starship prompt |
| `tmux` | `~/.tmux.conf` | tmux configuration |

## Scripts (top level)

| Script | Purpose |
|--------|---------|
| `./omarchy` | Stow all packages. Sets `STOW_FOLDERS`/`DOTFILES` defaults, then runs `./install`. Preferred entry point. |
| `./install` | Stow each package (skips any with conflicts, checked via `stow -n`), then runs `hypr restore` and `hyprctl reload` if Hyprland is running. |
| `./clean-env` | Unstow all packages (`stow -D`). Leaves `~/.config` as-is. |
| `./hypr` | Hyprland personal-overlay helper (see *The `hypr` utility*). |

Both `omarchy` and `install`/`clean-env` respect the env vars `STOW_FOLDERS`
(comma-separated package list) and `DOTFILES` (repo path), which is handy for
device-specific setups, e.g.:

```sh
STOW_FOLDERS="bash,bin,ghostty,hyprland,nvim,starship,tmux" ./omarchy
```

## First-time setup

### 1. Install packages manually

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

### 2. Remove defaults

You will need to remove some of the default files in `~/.config` subdirs, e.g.:

```
~/.config/ghostty/
~/.config/hypr/
~/.config/nvim/
```

Stow will not override existing files, so you must remove them yourself first. If a
package can't be stowed because a real file already exists at the target path, remove
that file and run `./omarchy` again — `./install` skips conflicted packages silently.

### 3. Run scripts

```sh
cd ~/.dotfiles
./omarchy          # stow everything, run hypr restore, reload Hyprland
```

To start completely clean (e.g. when re-imaging the machine):

```sh
cd ~/.dotfiles
./clean-env        # remove all stow symlinks
# then remove leftover real files in ~/.config that stow can't replace
./omarchy          # re-stow
```

## Hyprland layout (the important bit)

The whole point of this structure is that **Omarchy never overwrites your personal
Hyprland config**. Omarchy rewrites the top-level files in `~/.config/hypr/` during
`omarchy update` and `omarchy refresh`; your personal settings therefore live in a
subdirectory Omarchy never touches.

```
~/.config/hypr/
├── hyprland.conf            # glue — sources Omarchy defaults, then personal/*.conf LAST
├── personal/                # ← YOUR settings (git-tracked, stowed). Edit these.
│   ├── bindings.conf        #   keybindings (unbind/rebind against Omarchy defaults)
│   ├── input.conf           #   keyboard/mouse/touchpad
│   ├── looknfeel.conf       #   gaps, borders, animations
│   ├── autostart.conf       #   extra startup apps
│   ├── monitors.conf        #   display configuration
│   └── daemons/             #   complete configs for daemon-sourced files
│       ├── hypridle.conf    #     idle/lock/suspend timing
│       ├── hyprlock.conf    #     lock screen
│       ├── hyprsunset.conf  #     night light
│       └── xdph.conf        #     screen share portal
├── hypridle.conf            # shim → sources personal/daemons/hypridle.conf
├── hyprlock.conf            # shim → sources personal/daemons/hyprlock.conf
├── hyprsunset.conf          # shim → sources personal/daemons/hyprsunset.conf
├── xdph.conf                # shim → sources personal/daemons/xdph.conf
├── bindings.conf            # omarchy-owned (disposable)
├── input.conf               # omarchy-owned (disposable)
├── looknfeel.conf           # omarchy-owned (disposable)
├── autostart.conf           # omarchy-owned (disposable)
└── monitors.conf            # omarchy-owned (disposable)
```

Rules of thumb:

- **Never** edit the shims or the omarchy-owned files — they get replaced.
- **Always** edit `personal/*.conf` (Hyprland settings) or
  `personal/daemons/*.conf` (daemon settings). They are applied last, so they win.
- The four daemon configs (`hypridle`, `hyprlock`, `hyprsunset`, `xdph`) live in
  `personal/daemons/` and are complete configs; after editing one, re-run
  `./hypr restore` to push it into the top-level shim, then restart the daemon.
- `hyprland.conf` is the only stowed top-level file. It is a git-tracked symlink and is
  restored automatically after updates; avoid editing it directly unless you know what
  you're doing.

## The `hypr` utility

| Command | What it does |
|---------|--------------|
| `./hypr status` | Shows who owns each `~/.config/hypr` file (personal / omarchy / shim) and flags anything out of whack |
| `./hypr diff` | What changed in Omarchy's Hyprland defaults since the last `omarchy update` |
| `./hypr diff mine` | How your live configs differ from the current Omarchy defaults |
| `./hypr restore` | Re-wires the glue + shims and materializes any missing omarchy-owned files from Omarchy's defaults (safe to run anytime; run after editing a daemon config or if an update clobbered something) |
| `./hypr backup` | Snapshots `~/.config/hypr` into `~/.local/state/omarchy/hypr-updates/backups/` |

## Update workflow

1. Run `omarchy update` (the Omarchy CLI, not this repo's `./omarchy`).
2. Omarchy runs migrations (which may rewrite omarchy-owned files and shims), then
   runs the `post-update.d/99-hypr-personal` hook.
3. The hook runs `./hypr restore` (your glue + shims are guaranteed restored), saves a
   diff report of what changed in Omarchy's Hyprland defaults to
   `~/.local/state/omarchy/hypr-updates/<timestamp>.diff`, and shows a desktop
   notification with the path.
4. Open the report to see what Omarchy changed. Port anything you want into
   `personal/*.conf` (e.g. a new binding or default). Nothing is adopted automatically.

### After an update broke something

```sh
cd ~/.dotfiles
./hypr restore              # re-wire glue + shims
hyprctl reload && hyprctl configerrors   # verify
```

If `omarchy refresh hyprland` ever overwrote your glue `hyprland.conf`:

```sh
cd ~/.dotfiles
git checkout -- hyprland/.config/hypr/hyprland.conf
./hypr restore
```

## Where backups/reports live

- `~/.local/state/omarchy/hypr-updates/` — diff reports (one per update)
- `~/.local/state/omarchy/hypr-updates/backups/` — anything `hypr restore` replaced,
  plus `./hypr backup` snapshots
- The dotfiles git repo is itself the ultimate safety net: `git status` / `git diff`
  show any unexpected change to your configs.

## Troubleshooting

- **`hyprctl configerrors` reports errors after a change** — fix them in
  `personal/*.conf`, not the shims.
- **Waybar / walker changes** — these are not Hyprland; restart them with
  `omarchy restart waybar` / `omarchy restart walker`.
- **Keybinding clashes** — check current bindings with `omarchy menu keybindings --print`,
  then `unbind` before re-binding in `personal/bindings.conf`.
- **Forgot which package owns a file** — `readlink ~/.config/<path>`; if it points into
  `~/.dotfiles`, it's stowed.
