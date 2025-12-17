return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {
        menu = {
            width = vim.api.nvim_win_get_width(0) - 4,
        },
        settings = {
            save_on_toggle = true,
        },
    },
    keys = function()
        local harpoon = require("harpoon")

        local add_file = function()
            harpoon:list():add()
        end

        local keys = {
            {
                "<M-a>",
                add_file,
                desc = "Harpoon Add File",
            },
            {
                "<leader>a",
                add_file,
                desc = "Harpoon Add File",
            },
            {
                "<M-e>",
                function()
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                end,
                desc = "Harpoon Quick Menu",
            },
            {
                "<M-S-N>",
                function()
                    harpoon:list():next()
                end,
                desc = "Harpoon Next",
            },
            {
                "<M-S-P>",
                function()
                    harpoon:list():prev()
                end,
                desc = "Harpoon Prev",
            },
            {
                "<leader>hc",
                function()
                    harpoon:list():clear()
                end,
                desc = "Harpoon Clear List",
            },
        }

        local select_map = {
            h = 1,
            j = 2,
            k = 3,
            l = 4,
        }

        for key, index in pairs(select_map) do
            table.insert(keys, {
                "<M-" .. key .. ">",
                function()
                    harpoon:list():select(index)
                end,
                desc = "Harpoon to File " .. index,
            })
        end

        for key, index in pairs(select_map) do
            table.insert(keys, {
                "<M-S-" .. key .. ">",
                function()
                    harpoon:list():replace_at(index)
                end,
                desc = "Harpoon replace File " .. index,
            })
        end

        return keys
    end,
}
