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

        -- local zenActive = false

        vim.keymap.set("n", "<leader>zz", function()
            require("zen-mode").toggle()
            -- zenActive = not zenActive
            --
            -- if zenActive then
            --     vim.wo.wrap = true
            -- else
            --     vim.wo.wrap = false
            -- end

            ColorMyPencils()
        end, { desc = "Toggle Zen Mode and customize appearance" })
    end
}
