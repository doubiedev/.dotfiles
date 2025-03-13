return {
    setup = function()
        vim.wo.foldlevel = 99
        vim.wo.conceallevel = 2

        vim.keymap.set("n", "<leader>or", ":Neorg return<CR>")
        vim.keymap.set("n", "<leader>ow", ":Neorg workspace notes<CR>")
        vim.keymap.set("n", "<leader>oc", ":Neorg toggle-concealer<CR>")
        vim.keymap.set("n", "<leader>od", ":Neorg journal today<CR>")
        vim.keymap.set("n", "<leader>ot", ":Neorg journal tomorrow<CR>")
        vim.keymap.set("n", "<leader>oy", ":Neorg journal yesterday<CR>")

        require("neorg").setup({
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {
                    config = {
                        icon_preset = "diamond",
                    }
                },
                ["core.autocommands"] = {},
                ["core.integrations.treesitter"] = {},
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/notes",
                        },
                        default_workspace = "notes",
                    },
                },
            },
        })
    end
}
