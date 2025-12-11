-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and maintain cursor position" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and centre cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and centre cursor" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Search forward and centre view" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Search backward and centre view" })

vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Paste while keeping current text in register" })

vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "<C-[>", "<Esc>", { desc = "Exit insert mode" })

-- vim.keymap.set("n", "<M-h>", "<C-w>h", { desc = "Move to left split" })
-- vim.keymap.set("n", "<M-j>", "<C-w>j", { desc = "Move to below split" })
-- vim.keymap.set("n", "<M-k>", "<C-w>k", { desc = "Move to above split" })
-- vim.keymap.set("n", "<M-l>", "<C-w>l", { desc = "Move to right split" })
-- vim.keymap.set("n", "<M-q>", "<cmd>close<CR>", { desc = "Close split" })
-- vim.keymap.set("n", "<M-p>", "<C-w>p", { desc = "Switch to previous window" })
-- vim.keymap.set("n", "<M-w>", "<C-w>w", { desc = "Cycle through windows" })
