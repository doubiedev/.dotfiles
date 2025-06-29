return {
    setup = function()
        local builtin = require('telescope.builtin')
        require('telescope').load_extension("live_grep_args")
        local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")


        -- vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "Search for files in the project" })
        vim.keymap.set('n', '<leader>pf', function()
            builtin.find_files {
                find_command = { 'rg', '--files', '--hidden', '--glob', '!.git/**' },
            }
        end, { desc = "Search for files in the project" })
        vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Search for files in the Git repository" })
        vim.keymap.set('n', '<leader>ps', function()
            -- local word = vim.fn.expand("<cWORD>")
            -- builtin.grep_string({ search = word })
            live_grep_args_shortcuts.grep_word_under_cursor({
                additional_args = { "--hidden", "--glob", "!.git/**" },
            })
        end, { desc = "Search for the string under cursor across the project" })
        vim.keymap.set('n', '<leader>pS', function()
            require('telescope').extensions.live_grep_args.live_grep_args({
                additional_args = { "--hidden", "--glob", "!.git/**" },
            })
        end, { desc = "Search for a string across the project" })
    end
}
