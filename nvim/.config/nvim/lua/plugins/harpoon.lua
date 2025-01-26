return {
    setup = function()
        local harpoon = require("harpoon")

        -- REQUIRED
        harpoon:setup()
        -- REQUIRED

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add current file to Harpoon list" })
        vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "open Harpoon window" })

        vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end, { desc = "Select 1st file in Harpoon list" })
        vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end, { desc = "Select 2nd file in Harpoon list" })
        vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end, { desc = "Select 3rd file in Harpoon list" })
        vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end, { desc = "Select 4th file in Harpoon list" })

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Toggle previous buffer in Harpoon list" })
        vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Toggle next buffer in Harpoon list" })

        -- basic telescope configuration
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            local make_finder = function()
                local paths = {}

                for _, item in ipairs(harpoon_files.items) do
                    table.insert(paths, item.value)
                end

                return require("telescope.finders").new_table({
                    results = paths,
                })
            end

            require("telescope.pickers")
                .new({}, {
                    prompt_title = "Harpoon",
                    finder = require("telescope.finders").new_table({
                        results = file_paths,
                    }),
                    previewer = false,
                    sorter = conf.generic_sorter({}),
                    layout_strategy = "center",
                    layout_config = {
                        preview_cutoff = 1,
                        width = function(_, max_columns, _)
                            return math.min(max_columns, 80)
                        end,
                        height = function(_, _, max_lines)
                            return math.min(max_lines, 15)
                        end,
                    },
                    borderchars = {
                        prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
                        results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
                        preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                    },
                    attach_mappings = function(prompt_buffer_number, map)
                        map("i", "<C-d>", function()
                            local state = require("telescope.actions.state")
                            local selected_entry = state.get_selected_entry()
                            local current_picker = state.get_current_picker(prompt_buffer_number)

                            harpoon:list():remove(selected_entry)
                            current_picker:refresh(make_finder())
                        end, { desc = "Delete selected entry from Harpoon list" })

                        return true
                    end,
                }):find()
        end

        vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
            { desc = "Open Harpoon window with telescope" })
    end
}
