return {
    setup = function()
        vim.keymap.set("n", "<leader>tsl", ":TimerSession long<CR>", { desc = "Start a 50m pomodoro" })
        vim.keymap.set("n", "<leader>tss", ":TimerSession short<CR>", { desc = "Start a 25m pomodoro" })
        vim.keymap.set("n", "<leader>th", ":TimerHide<CR>", { desc = "Hide pomodoro timer" })
        vim.keymap.set("n", "<leader>tH", ":TimerShow<CR>", { desc = "Show pomorodo timer" })

        require("pomo").setup({
            -- How often the notifiers are updated.
            update_interval = 1000,

            -- Configure the default notifiers to use for each timer.
            -- You can also configure different notifiers for timers given specific names, see
            -- the 'timers' field below.
            notifiers = {
                -- The "Default" notifier uses 'vim.notify' and works best when you have 'nvim-notify' installed.
                {
                    name = "Default",
                    opts = {
                        -- With 'nvim-notify', when 'sticky = true' you'll have a live timer pop-up
                        -- continuously displayed. If you only want a pop-up notification when the timer starts
                        -- and finishes, set this to false.
                        sticky = false,

                        -- Configure the display icons:
                        title_icon = "󱎫",
                        text_icon = "󰄉",
                        -- Replace the above with these if you don't have a patched font:
                        -- title_icon = "⏳",
                        -- text_icon = "⏱️",
                    },
                },

                { name = "System" },
            },

            -- Override the notifiers for specific timer names.
            -- timers = {
            --     -- For example, use only the "System" notifier when you create a timer called "Break",
            --     -- e.g. ':TimerStart 2m Break'.
            --     Break = {
            --         { name = "System" },
            --     },
            -- },
            -- You can optionally define custom timer sessions.
            sessions = {
                long = {
                    { name = "Work",       duration = "50m" },
                    { name = "Long Break", duration = "10m" },
                },
                short = {
                    { name = "Work",        duration = "25m" },
                    { name = "Short Break", duration = "5m" },
                },
            },
        })
    end
}
