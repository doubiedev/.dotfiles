return {
    setup = function()
        local builtin = require('telescope.builtin')

        -- vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = "Search for files in the project" })
        vim.keymap.set('n', '<leader>pf', function()
            builtin.find_files {
                find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
            }
        end, { desc = "Search for files in the project" })
        vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Search for files in the Git repository" })
        vim.keymap.set('n', '<leader>ps', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end, { desc = "Search for the string under cursor across the project" })
        vim.keymap.set('n', '<leader>pS', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") });
        end, { desc = "Search for a string across the project" })
    end
}
