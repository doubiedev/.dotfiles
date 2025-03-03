-- ============================================================================
-- LAZY - Bootstrap lazy
-- ============================================================================
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

-- vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- ============================================================================
-- REMAPS
-- ============================================================================
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

vim.keymap.set("n", "Y", "yg$", { desc = "Yank to the end of the line" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and maintain cursor position" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and centre cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and centre cursor" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Search forward and centre view" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Search backward and centre view" })

-- greatest remap ever
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Paste while keeping current text in register" })

-- next greatest remap ever
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Yank to clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Yank selected text to clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Yank current line to clipboard" })

vim.keymap.set("n", "<leader>d", "\"_d", { desc = "Delete without yanking" })
vim.keymap.set("v", "<leader>d", "\"_d", { desc = "Delete selection without yanking" })

vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("i", "<C-[>", "<Esc>", { desc = "Exit insert mode" })

vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Q key" })
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Open a new tmux session" })
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end, { desc = "Format current buffer" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Go to next quickfix item" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Go to previous quickfix item" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Go to next location list item" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Go to previous location list item" })

vim.keymap.set("n", "<leader>h", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<leader>l", "<C-w>l", { desc = "Move to right split" })

vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
    { desc = "Search and replace for word under cursor" })
vim.keymap.set("v", "<leader>s", ":s/", { desc = "Search and replace selected text" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make current file executable" })

vim.keymap.set("n", "<leader>ww", "<cmd>set wrap!<CR>", { desc = "Toggle line wrapping" })

-- ============================================================================
-- SETTINGS (VIM)
-- ============================================================================
vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true


vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.conceallevel = 1

vim.g.mapleader = " "

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- ============================================================================
-- SETTINGS (VIM - OTHER)
-- ============================================================================

local augroup = vim.api.nvim_create_augroup
local doubiedevGroup = augroup('doubiedev', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    group = doubiedevGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- ============================================================================
-- LAZY - SETUP
-- ============================================================================
-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        'ThePrimeagen/vim-be-good',
        'RishabhRD/popfix',
        'RishabhRD/nvim-cheat.sh',
        'folke/zen-mode.nvim',
        'mbbill/undotree',
        'tpope/vim-fugitive',
        {
            'nvim-telescope/telescope.nvim',
            version = '0.1.8',
            dependencies = { 'nvim-lua/plenary.nvim' }
        },
        {
            'rose-pine/neovim',
            name = 'rose-pine',
            config = function()
                vim.cmd('colorscheme rose-pine')
            end
        },
        {
            'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',
            lazy = true,
        },
        {
            'nvim-treesitter/nvim-treesitter-context',
            lazy = true,
            dependencies = { 'nvim-treesitter/nvim-treesitter' },
        },
        {
            'ThePrimeagen/harpoon',
            branch = 'harpoon2',
            dependencies = { 'nvim-lua/plenary.nvim' }
        },
        {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v3.x',
            dependencies = {
                'williamboman/mason.nvim',
                'williamboman/mason-lspconfig.nvim',
                'neovim/nvim-lspconfig',
                'hrsh7th/nvim-cmp',
                'hrsh7th/cmp-nvim-lsp',
                'L3MON4D3/LuaSnip',
                'saadparwaiz1/cmp_luasnip',
                'rafamadriz/friendly-snippets',
            }
        },
        {
            'MeanderingProgrammer/render-markdown.nvim',
            dependencies = {
                'nvim-treesitter/nvim-treesitter',
                'echasnovski/mini.nvim', -- if you use the mini.nvim suite
            },
        },
        {
            "iamcco/markdown-preview.nvim",
            cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
            ft = { 'markdown' },
            -- build = function()
            --     vim.cmd [[Lazy load markdown-preview.nvim]]
            --     vim.fn['mkdp#util#install']()
            -- end,
            build = ":call mkdp#util#install()",
        },
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
        {
            "oysandvik94/curl.nvim",
            cmd = { "CurlOpen" },
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
            config = true,
        },
        {
            "folke/which-key.nvim",
            event = "VeryLazy",
            opts = {},
            keys = {
                {
                    "<leader>?",
                    function()
                        require("which-key").show({ global = false })
                    end,
                    desc = "Buffer Local Keymaps (which-key)",
                },
            },
        },
        {
            "echasnovski/mini.nvim",
            version = '*',
        },
        {
            "atiladefreitas/dooing",
        },
        {
            "folke/todo-comments.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            opts = {}
        },
        {
            "windwp/nvim-ts-autotag",
        },
        {
            "epwalsh/obsidian.nvim",
            version = "*",
            lazy = true,
            event = {
                "BufReadPre " .. vim.fn.expand "~" .. "personal/notes/*.md",
                "BufNewFile " .. vim.fn.expand "~" .. "personal/notes/*.md",
            },
            dependencies = {
                "nvim-lua/plenary.nvim",
                "hrsh7th/nvim-cmp",
                "nvim-telescope/telescope.nvim",
                "nvim-treesitter/nvim-treesitter",
            },
        },
        {
            "rmagatti/auto-session",
            lazy = false,
        },
        -- {
        --     "epwalsh/pomo.nvim",
        --     version = "*",
        --     lazy = true,
        --     cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
        --     dependencies = {
        --         "rcarriga/nvim-notify",
        --     },
        -- },
        -- {
        --     "stevearc/oil.nvim",
        --     dependencies = {
        --         "echasnovski/mini.icons"
        --     },
        --     lazy = false,
        -- }
        {
            "kdheepak/lazygit.nvim",
            lazy = true,
            cmd = {
                "LazyGit",
                "LazyGitConfig",
                "LazyGitCurrentFile",
                "LazyGitFilter",
                "LazyGitFilterCurrentFile",
            },
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
            -- setting the keybinding for LazyGit with 'keys' is recommended in
            -- order to load the plugin when the command is run for the first time
            keys = {
                { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
            }
        },
        {
            "nvzone/typr",
            dependencies = "nvzone/volt",
            opts = {},
            cmd = { "Typr", "TyprStats" },
        },
        {
            "habamax/vim-godot",
            event = 'VimEnter',
        },
    },

    -- Configure any other settings here. See the documentation for more details.
    -- ------------------------------------------------------------------------
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "rose-pine" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})

require("plugins.colors").setup()
require("plugins.fugitive").setup()
require("plugins.harpoon").setup()
require("plugins.telescope").setup()
require("plugins.treesitter").setup()
require("plugins.undotree").setup()
require("plugins.zenmode").setup()
require("plugins.lsp").setup()
require("plugins.curl").setup()
require("plugins.which-key").setup()
require("plugins.dooing").setup()
require("plugins.todo-comments").setup()
require("plugins.ts-autotag").setup()
require("plugins.render-markdown").setup()
require("plugins.obsidian").setup()
-- require("plugins.pomo").setup()
-- require("plugins.oil").setup()

require("mini.icons").setup()
require("mini.surround").setup()
