return {
    -- NOTE: Base utilities used by many plugins
    "nvim-lua/plenary.nvim",

    -- NOTE: Base themes and UI core
    {
        "nvchad/base46",
        build = function()
            require("base46").load_all_highlights()
        end,
    },

    -- NOTE: NVChad's core UI module for layout and appearance
    {
        "nvchad/ui",
        lazy = false,
        config = function()
            require("nvchad")
        end,
    },

    -- NOTE: Volt theme (custom UI theme extension)
    "nvzone/volt",

    -- NOTE: Adds file-type icons to Neovim (used by statuslines, nvim-tree, etc.)
    {
        "nvim-tree/nvim-web-devicons",
        lazy = false,
        opts = function()
            dofile(vim.g.base46_cache .. "devicons")
            return { override = require("nvchad.icons.devicons") }
        end,
    },

    -- NOTE: Visual indentation guides and scope lines
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "User FilePost",
        opts = function()
            return require("configs.indent-blankline").opts
        end,
        config = function(_, opts)
            require("configs.indent-blankline").config(_, opts)
        end,
    },

    -- NOTE: File explorer sidebar
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        opts = function()
            return require("configs.nvimtree")
        end,
    },

    -- NOTE: Shows a popup with keybinding hints as you type
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
        cmd = "WhichKey",
        opts = require("configs.whichkey"),
    },

    -- NOTE: Auto-formatting plugin using external formatters (e.g., stylua for Lua)
    {
        "stevearc/conform.nvim",
        opts = function()
            return require("configs.conform")
        end,
    },

    -- NOTE: Git integration: shows added/changed/removed lines in the gutter
    {
        "lewis6991/gitsigns.nvim",
        event = "User FilePost",
        config = function()
            local gitsigns = require("configs.gitsigns")
            gitsigns.opts.on_attach = gitsigns.on_attach
            require("gitsigns").setup(gitsigns.opts)
        end,
    },

    -- NOTE: Manages LSP servers and tools via Mason UI
    {
        "mason-org/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUpdate" },
        opts = function()
            return require("configs.mason")
        end,
    },

    -- NOTE: Configures LSP client support for Neovim
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile", "User FilePost" },
        config = function()
            require("configs.lspconfig").defaults()
            require("configs.lspconfig")
        end,
    },

    -- NOTE: Integrates Mason with lspconfig
    {
        "mason-org/mason-lspconfig.nvim",
        event = "VeryLazy",
        config = function()
            require("configs.mason-lspconfig")
        end,
    },

    -- NOTE: Snippet engine for completion
    {
        "L3MON4D3/LuaSnip",
        event = { "BufReadPre", "InsertEnter" },
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        build = "make install_jsregexp",
        config = function()
            require("configs.luasnip").setup()
        end,
    },

    -- NOTE: Automatically insert matching parentheses, brackets, quotes, etc.
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("configs.autopairs").setup()
        end,
    },

    -- NOTE: Main completion engine
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        opts = function()
            return require("configs.cmp")
        end,
    },

    -- NOTE: nvim-cmp source: LuaSnip
    {
        "saadparwaiz1/cmp_luasnip",
        event = "InsertEnter",
    },

    -- NOTE: nvim-cmp source: Neovim Lua API
    {
        "hrsh7th/cmp-nvim-lua",
        event = "InsertEnter",
    },

    -- NOTE: nvim-cmp source: LSP
    {
        "hrsh7th/cmp-nvim-lsp",
        event = "InsertEnter",
    },

    -- NOTE: nvim-cmp source: current buffer words
    {
        "hrsh7th/cmp-buffer",
        event = "InsertEnter",
    },

    -- NOTE: nvim-cmp source: file paths
    {
        "hrsh7th/cmp-path",
        event = "InsertEnter",
    },

    -- NOTE: Treesitter for syntax highlighting and parsing
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile", "BufReadPost" },
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        config = function()
            require("configs.treesitter")
        end,
    },

    -- NOTE: Extra text objects (functions, loops, blocks) for Treesitter
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "VeryLazy",
        config = function()
            require("configs.treesitter-textobjects")
        end,
    },

    -- NOTE: Auto-close and auto-rename HTML/JSX tags
    {
        "windwp/nvim-ts-autotag",
        event = "VeryLazy",
        config = function()
            require("nvim-ts-autotag").setup({})
        end,
    },

    -- NOTE: Powerful fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        opts = function()
            return require("configs.telescope")
        end,
    },

    -- NOTE: Highlight and manage TODO, FIX, HACK comments
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        config = function()
            require("configs.todo-comments").setup()
        end,
    },

    -- NOTE: Add/change/delete surrounding characters like parentheses, quotes, etc.
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },

    -- NOTE: Adds a centered command-line popup.
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("configs.noice").setup()
        end,
    },
}
