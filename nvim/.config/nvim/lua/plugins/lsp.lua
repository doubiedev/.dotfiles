return {
    setup = function()
        local lsp = require('lsp-zero')

        lsp.preset('recommended')

        local cmp = require('cmp')
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_mappings = lsp.defaults.cmp_mappings({
            ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
            ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),
            ['<C-Space>'] = cmp.mapping.complete(),
        })

        -- disable completion with tab
        -- this helps with copilot setup
        cmp_mappings['<Tab>'] = nil
        cmp_mappings['<S-Tab>'] = nil

        cmp.setup({
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },         -- if using snippets
                { name = 'render-markdown' }, -- Add this line
            }),
        })

        lsp.set_preferences({
            suggest_lsp_servers = false,
            sign_icons = {
                error = 'E',
                warn = 'W',
                hint = 'H',
                info = 'I'
            }
        })

        vim.diagnostic.config({
            virtual_text = true,
        })

        lsp.setup({
            mapping = cmp_mappings
        })

        lsp.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }

            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts,
                { desc = "Go to the definition of the symbol under the cursor" })
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts, { desc = "Show hover documentation" })
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts,
                { desc = "Search for workspace symbols" })
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts,
                { desc = "Show diagnostics in a floating window" })
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts,
                { desc = "Jump to the next diagnostic" })
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts,
                { desc = "Jump to the previous diagnostic" })
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts,
                { desc = "Trigger code actions at the current cursor" })
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts,
                { desc = "Show references to the symbol under the cursor" })
            vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts,
                { desc = "Rename the symbol under the cursor" })
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts,
                { desc = "Show function signature help" })
        end)

        -- if client.name == "eslint" then
        --     vim.cmd [[ LspStop eslint ]]
        --     return
        -- end

        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = {
                'eslint',
                'lua_ls',
                'gopls',
            },
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,
            },
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' },
                    },
                },
            },
        })

        lsp.setup()
    end
}
