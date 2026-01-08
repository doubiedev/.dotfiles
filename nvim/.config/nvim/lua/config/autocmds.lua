-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Disable tabline by default at startup
vim.api.nvim_create_autocmd("BufReadPre", {
    group = vim.api.nvim_create_augroup("showtabline", { clear = true }),
    callback = function()
        vim.opt.showtabline = 0
    end,
    desc = "Set tabline to 0 / Disable tabline",
})
