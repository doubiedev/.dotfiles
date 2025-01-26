return {
    setup = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Open Git status" })

        local doubiedev_Fugitive = vim.api.nvim_create_augroup("doubiedev_Fugitive", {})

        local autocmd = vim.api.nvim_create_autocmd
        autocmd("BufWinEnter", {
            group = doubiedev_Fugitive,
            pattern = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end

                local bufnr = vim.api.nvim_get_current_buf()
                local opts = {buffer = bufnr, remap = false}
                print("great success", vim.bo.ft, bufnr, vim.inspect(opts))
                vim.keymap.set("n", "<leader>gp", function()
                    vim.cmd [[ Git push ]]
                end, opts, { desc = "Push changes to the remote repository" })

                -- rebase always
                vim.keymap.set("n", "<leader>gP", function()
                    vim.cmd [[ Git pull --rebase ]]
                end, opts, { desc = "Pull changes from the remote with rebase" })

                -- NOTE: It allows me to easily set the branch i am pushing and any tracking
                -- needed if i did not set the branch up correctly
                vim.keymap.set("n", "<leader>gt", ":Git push -u origin ", opts, { desc = "Push branch to remote with tracking" });
            end,
        })
    end
}

