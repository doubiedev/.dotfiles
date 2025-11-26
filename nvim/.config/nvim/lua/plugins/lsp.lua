return {
    setup = function()
        vim.opt.signcolumn = 'yes'

        local base_capabilities = vim.lsp.protocol.make_client_capabilities()
        local capabilities = vim.tbl_deep_extend(
            "force",
            base_capabilities,
            require("cmp_nvim_lsp").default_capabilities()
        )

        -----------------------------------------------------------------------
        -- LspAttach Keymaps
        -----------------------------------------------------------------------
        vim.api.nvim_create_autocmd("LspAttach", {
            desc = "LSP actions",
            callback = function(event)
                local opts = { buffer = event.buf }

                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
                vim.keymap.set({ "n", "x" }, "<F3>", function()
                    vim.lsp.buf.format({ async = true })
                end, opts)
                vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)

                vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
                vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
                vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
            end,
        })

        -----------------------------------------------------------------------
        -- GDScript LSP
        -----------------------------------------------------------------------
        vim.lsp.config("gdscript", {
            capabilities = capabilities,
            -- cmd = { "godot-wsl-lsp" },
        })

        -----------------------------------------------------------------------
        -- Toggle Godot server
        -----------------------------------------------------------------------
        local godot_server_id = nil

        vim.keymap.set("n", "<leader>gd", function()
            if godot_server_id == nil then
                godot_server_id = vim.fn.serverstart("127.0.0.1:6004")
                print("Godot server started on 127.0.0.1:6004")
            else
                vim.fn.serverstop(godot_server_id)
                godot_server_id = nil
                print("Godot server stopped")
            end
        end, { noremap = true, silent = true })

        -----------------------------------------------------------------------
        -- Toggle Godot theme
        -----------------------------------------------------------------------
        local godot_theme_enabled = false
        local original_colorscheme = vim.g.colors_name

        vim.keymap.set("n", "<leader>gt", function()
            if not godot_theme_enabled then
                original_colorscheme = vim.g.colors_name
                vim.cmd("colorscheme godotcolor")
                godot_theme_enabled = true
                print("Switched to Godot theme")
            else
                if original_colorscheme then
                    vim.cmd("colorscheme " .. original_colorscheme)
                else
                    print("No previous colorscheme found (using default)")
                end
                godot_theme_enabled = false
                print("Restored original theme: " .. (original_colorscheme or "default"))
            end
        end, { noremap = true, silent = true })

        -----------------------------------------------------------------------
        -- CMP
        -----------------------------------------------------------------------
        local cmp = require("cmp")
        -- require("luasnip.loaders.from_vscode").lazy_load()
        -- require("vim-react-snippets").lazy_load()

        cmp.setup({
            sources = {
                { name = "nvim_lsp" },
                -- { name = "luasnip" },
                { name = "render-markdown" },
            },
            formatting = {
                fields = { "abbr", "kind", "menu" },
            },
            experimental = {
                ghost_text = false,
            },
            completion = {
                -- THIS LINE STOPS DOUBLE INSERTS
                completeopt = "menu,menuone,noinsert",
            },

            snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<C-f>"] = cmp.mapping.scroll_docs(5),
                ["<C-u>"] = cmp.mapping.scroll_docs(-5),
                ["<C-e>"] = cmp.mapping(function()
                    if cmp.visible() then cmp.abort() else cmp.complete() end
                end),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    local col = vim.fn.col(".") - 1
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = "select" })
                    elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
                        fallback()
                    else
                        cmp.complete()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
                ["<C-d>"] = cmp.mapping(function(fallback)
                    local luasnip = require("luasnip")
                    if luasnip.jumpable(1) then luasnip.jump(1) else fallback() end
                end, { "i", "s" }),
            }),
        })

        -----------------------------------------------------------------------
        -- Diagnostics
        -----------------------------------------------------------------------
        vim.diagnostic.config({
            virtual_text = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "E",
                    [vim.diagnostic.severity.WARN] = "W",
                    [vim.diagnostic.severity.HINT] = "H",
                    [vim.diagnostic.severity.INFO] = "I",
                },
            },
        })

        -----------------------------------------------------------------------
        -- Mason
        -----------------------------------------------------------------------
        require("mason").setup({})
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "marksman",
            },
            handlers = {
                function(server)
                    if server == "eslint" then return end
                    vim.lsp.config(server, {
                        capabilities = capabilities,
                    })
                end,
            },
            automatic_installation = true,
        })
    end,
}
