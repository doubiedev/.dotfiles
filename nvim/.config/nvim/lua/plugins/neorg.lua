return {
    setup = function()
        require("neorg").setup({
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {
                    config = {
                        icon_preset = "varied",
                    }
                },
                ["core.autocommands"] = {},
                ["core.integrations.treesitter"] = {},
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/personal/neorg",
                        },
                        default_workspace = "notes",
                    },
                },
            },
        })

        vim.wo.foldlevel = 99
        vim.wo.conceallevel = 2
    end
}
