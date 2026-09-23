-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- APPLICATIONS, TUIs, WEB APPS --
hl.unbind("SUPER + SHIFT + M")
o.bind(
	"SUPER + SHIFT + M",
	"Music",
	'omarchy-launch-or-focus-webapp "YouTube Music" "https://music.youtube.com/" --profile-directory="Music"'
)

hl.unbind("SUPER + SHIFT + O")
o.bind(
	"SUPER + SHIFT + O",
	"Obsidian",
	'omarchy-launch-or-focus ^obsidian$ "uwsm-app -- obsidian --password-store=gnome-libsecret -disable-gpu --enable-wayland-ime"'
)
o.bind("SUPER + SHIFT + O", "Obsidian", { launch = "obsidian", focus = "^obsidian$" })

hl.unbind("SUPER + SHIFT + SLASH")
o.bind("SUPER + SHIFT + SLASH", "Passwords", "uwsm-app -- bitwarden.desktop")

hl.unbind("SUPER + M")
o.bind("SUPER + M", "hypruler", "hypruler")

-- TODO: Handle ZenNotes Quick Capture window rules
-- BUG: Mouse cursor/focus leaving window causes it to close
hl.unbind("SUPER + N")
o.bind("SUPER + N", "ZenNotes quick capture", "xdg-open zennotes://quick-capture")

-- UTILITIES --
hl.unbind("SUPER + D")
o.bind("SUPER + D", "Apps menu", "omarchy-menu toggle apps")

-- TILING --
hl.unbind("SUPER + J")
o.bind("SUPER + ALT + V", "Toggle window split", hl.dsp.layout("togglesplit"))
-- hl.unbind("SUPER + V")

hl.unbind("SUPER + K")
o.bind("SUPER + B", "Keybindings", "omarchy-menu-keybindings")

-- ---WINDOWS & WORKSPACES---
-- Move focus with SUPER + (hjkl)
hl.unbind("SUPER + CTRL + L") -- Lock system

hl.unbind("SUPER + L") -- Toggle workspace layout
o.bind("SUPER + ALT + T", "Toggle workspace layout", "omarchy-hyprland-workspace-layout-toggle")

-- Toggle "notes" special workspace
hl.unbind("SUPER + GRAVE")
o.bind("SUPER + GRAVE", "Toggle notes scratchpad", hl.dsp.workspace.toggle_special("notes"))
o.bind(
	"SUPER + ALT + GRAVE",
	"Move window to notes scratchpad",
	hl.dsp.window.move({ workspace = "special:notes", follow = false })
)
o.bind("SUPER + H", "Focus on left window", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + L", "Focus on right window", hl.dsp.focus({ direction = "r" }))
o.bind("SUPER + K", "Focus on above window", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + J", "Focus on below window", hl.dsp.focus({ direction = "d" }))

hl.unbind("SUPER + TAB")
hl.unbind("SUPER + SHIFT + TAB")
hl.unbind("SUPER + CTRL + TAB")
o.bind("SUPER + TAB", "Former workspace", hl.dsp.focus({ workspace = "previous" }))
o.bind("SUPER + CTRL + TAB", "Next workspace", hl.dsp.focus({ workspace = "e+1" }))
o.bind("SUPER + CTRL + SHIFT + TAB", "Previous workspace", hl.dsp.focus({ workspace = "e-1" }))

o.bind("SUPER + SHIFT + ALT + H", "Move workspace to left monitor", hl.dsp.workspace.move({ monitor = "l" }))
o.bind("SUPER + SHIFT + ALT + L", "Move workspace to right monitor", hl.dsp.workspace.move({ monitor = "r" }))
o.bind("SUPER + SHIFT + ALT + K", "Move workspace to up monitor", hl.dsp.workspace.move({ monitor = "u" }))
o.bind("SUPER + SHIFT + ALT + J", "Move workspace to down monitor", hl.dsp.workspace.move({ monitor = "d" }))

o.bind("SUPER + SHIFT + H", "Swap window to the left", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + SHIFT + L", "Swap window to the right", hl.dsp.window.swap({ direction = "r" }))
o.bind("SUPER + SHIFT + K", "Swap window up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + SHIFT + J", "Swap window down", hl.dsp.window.swap({ direction = "d" }))

o.bind("SUPER + ALT + H", "Move window to group on left", hl.dsp.window.move({ into_group = "l" }))
o.bind("SUPER + ALT + L", "Move window to group on right", hl.dsp.window.move({ into_group = "r" }))
o.bind("SUPER + ALT + K", "Move window to group on top", hl.dsp.window.move({ into_group = "u" }))
o.bind("SUPER + ALT + J", "Move window to group on bottom", hl.dsp.window.move({ into_group = "d" }))

o.bind("SUPER + CTRL + H", "Move grouped window focus left", hl.dsp.group.prev())
o.bind("SUPER + CTRL + L", "Move grouped window focus right", hl.dsp.group.next())
