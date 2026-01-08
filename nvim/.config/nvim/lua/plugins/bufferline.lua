local function toggle_tabline()
    local showtabline = vim.api.nvim_get_option_value("showtabline", { scope = "global" })
    if showtabline > 0 then
        vim.api.nvim_set_option_value("showtabline", 0, { scope = "global" }) -- disable tabline
    else
        vim.api.nvim_set_option_value("showtabline", 2, { scope = "global" }) -- always show tabline
    end
end
vim.api.nvim_create_user_command("ToggleTabline", function()
    toggle_tabline()
end, {})

return {
    {
        "akinsho/bufferline.nvim",
        event = function() -- only load by keys
            return {}
        end,
        keys = {                                                                        -- only load by keys
            { "<leader>bt", "<cmd>ToggleTabline<cr>", desc = "Toggle buffer tabline" }, -- can also use default <leader>uA keybind
        },
        opts = {
            options = {
                always_show_bufferline = true,
            },
        },
        config = function(_, opts)
            require("bufferline").setup(opts)
            vim.cmd("ToggleTabline")
        end,
    },
}
