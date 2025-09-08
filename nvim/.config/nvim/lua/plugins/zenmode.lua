return {
    setup = function()
        require("zen-mode").setup {
            window = {
                width = 120,
                options = {
                    number = true,
                    relativenumber = true,
                }
            },
        }

        vim.keymap.set("n", "<leader>zz", function()
            require("zen-mode").toggle()
            ColorMyPencils()
        end, { desc = "Toggle Zen Mode" })

        vim.keymap.set("n", "<leader>zw", function()
            require("zen-mode").toggle()
            vim.cmd("set wrap!")
            ColorMyPencils()
        end, { desc = "Toggle Zen Mode with line wrapping" })
    end
}
