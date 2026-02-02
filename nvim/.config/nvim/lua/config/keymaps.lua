-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Editing Lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down", silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up", silent = true })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and maintain cursor position" })

-- Scroll & Search
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and centre cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and centre cursor" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Search forward and centre view" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Search backward and centre view" })

-- Yank & Paste
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Paste while keeping current text in register" })
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Yank to clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Yank selected text to clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Yank current line to clipboard" })

vim.keymap.set("n", "<leader>d", "\"_d", { desc = "Delete without yanking" })
vim.keymap.set("v", "<leader>d", "\"_d", { desc = "Delete selection without yanking" })

-- Escape remaps
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "<C-[>", "<Esc>", { desc = "Exit insert mode" })

-- Other
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Q key" })

-- ===PLUGINS===
-- Supermaven
vim.keymap.set("n", "<leader>C", ":SupermavenToggle<CR>", { desc = "Toggle AI code completion" })
