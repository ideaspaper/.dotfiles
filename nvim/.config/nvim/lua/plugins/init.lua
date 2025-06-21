return {
    -- Base utilities used by many plugins
    "nvim-lua/plenary.nvim",
    -- Base themes and UI core
    {
        "nvchad/base46",
        build = function()
            require("base46").load_all_highlights()
        end,
    },
    -- NVChad's core UI module for layout and appearance
    {
        "nvchad/ui",
        lazy = false,
        config = function()
            require("nvchad")
        end,
    },
    -- Volt theme (custom UI theme extension)
    "nvzone/volt",
    -- Adds file-type icons to Neovim (used by statuslines, nvim-tree, etc.)
    {
        "nvim-tree/nvim-web-devicons",
        lazy = false,
        opts = function()
            dofile(vim.g.base46_cache .. "devicons")
            return { override = require("nvchad.icons.devicons") }
        end,
    },
    -- Visual indentation guides and scope lines
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "User FilePost",
        opts = function()
            return {
                indent = { char = "│", highlight = "IblChar" },
                scope = { char = "│", highlight = "IblScopeChar" },
            }
        end,
        config = function(_, opts)
            dofile(vim.g.base46_cache .. "blankline")

            local hooks = require("ibl.hooks")
            hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
            require("ibl").setup(opts)

            dofile(vim.g.base46_cache .. "blankline")
        end,
    },
    -- File explorer sidebar
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        opts = function()
            return require("configs.nvimtree")
        end,
    },
    -- Shows a popup with keybinding hints as you type
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
        cmd = "WhichKey",
        opts = function()
            dofile(vim.g.base46_cache .. "whichkey")
            return {}
        end,
    },
    -- Auto-formatting plugin using external formatters (e.g., stylua for Lua)
    {
        "stevearc/conform.nvim",
        opts = function()
            return {
                formatters_by_ft = {
                    lua = { "stylua" },
                },
            }
        end,
    },
    -- Git integration: shows added/changed/removed lines in the gutter
    {
        "lewis6991/gitsigns.nvim",
        event = "User FilePost",
        config = function()
            require("gitsigns").setup({
                on_attach = function(bufnr)
                    local gs = require("gitsigns")
                    vim.keymap.set("n", "]c", function()
                        gs.next_hunk()
                    end, { desc = "next hunk", buffer = bufnr })
                    vim.keymap.set("n", "[c", function()
                        gs.prev_hunk()
                    end, { desc = "prev hunk", buffer = bufnr })
                    vim.keymap.set("n", "<leader>cs", gs.stage_hunk, { desc = "stage hunk", buffer = bufnr })
                    vim.keymap.set("n", "<leader>cu", gs.undo_stage_hunk, { desc = "undo stage hunk", buffer = bufnr })
                    vim.keymap.set("n", "<leader>cr", gs.reset_hunk, { desc = "reset hunk", buffer = bufnr })
                    vim.keymap.set("n", "<leader>cp", gs.preview_hunk, { desc = "preview hunk", buffer = bufnr })
                    vim.keymap.set("n", "<leader>cB", function()
                        gs.blame_line({ full = true })
                    end, { desc = "blame line", buffer = bufnr })
                    vim.keymap.set("n", "<leader>cD", gs.diffthis, { desc = "diff this", buffer = bufnr })
                    vim.keymap.set(
                        "n",
                        "<leader>cS",
                        ":Gitsigns stage_buffer<CR>",
                        { desc = "stage buffer", buffer = bufnr }
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>cU",
                        ":Gitsigns reset_buffer<CR>",
                        { desc = "reset buffer", buffer = bufnr }
                    )
                    vim.keymap.set("v", "<leader>cs", function()
                        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, { desc = "stage selection", buffer = bufnr })
                    vim.keymap.set("v", "<leader>gr", function()
                        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                    end, { desc = "reset selection", buffer = bufnr })
                    vim.keymap.set(
                        { "o", "x" },
                        "ih",
                        ":<C-U>Gitsigns select_hunk<CR>",
                        { desc = "inner hunk", buffer = bufnr }
                    )
                    vim.keymap.set(
                        { "o", "x" },
                        "ah",
                        ":<C-U>Gitsigns select_hunk<CR>",
                        { desc = "around hunk", buffer = bufnr }
                    )
                    vim.keymap.set(
                        "n",
                        "<leader>cb",
                        gs.toggle_current_line_blame,
                        { desc = "toggle blame", buffer = bufnr }
                    )
                end,
            })
        end,
    },
    -- Manages LSP servers and tools via Mason UI
    {
        "mason-org/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUpdate" },
        opts = function()
            return require("configs.mason")
        end,
    },
    -- Configures LSP client support for Neovim
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile", "User FilePost" },
        config = function()
            require("configs.lspconfig").defaults()
            require("configs.lspconfig")
        end,
    },
    -- Integrates Mason with lspconfig
    {
        "mason-org/mason-lspconfig.nvim",
        event = "VeryLazy",
        config = function()
            require("configs.mason-lspconfig")
        end,
    },
    -- Snippet engine for completion
    {
        "L3MON4D3/LuaSnip",
        event = { "BufReadPre", "InsertEnter" },
        dependencies = {
            {
                "rafamadriz/friendly-snippets",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                end,
            },
        },
        opts = function()
            return {
                history = true,
                updateevents = "TextChanged,TextChangedI",
            }
        end,
        config = function(_, opts)
            local luasnip = require("luasnip")
            luasnip.config.set_config(opts)
            require("configs.luasnip")
        end,
    },
    -- Automatically insert matching parentheses, brackets, quotes, etc.
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = function()
            return {
                fast_wrap = {},
                disable_filetype = { "TelescopePrompt", "vim" },
            }
        end,
        config = function(_, opts)
            require("nvim-autopairs").setup(opts)
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },
    -- Main completion engine
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        opts = function()
            return require("configs.cmp")
        end,
    },
    -- nvim-cmp source: LuaSnip
    {
        "saadparwaiz1/cmp_luasnip",
        event = "InsertEnter",
    },
    -- nvim-cmp source: Neovim Lua API
    {
        "hrsh7th/cmp-nvim-lua",
        event = "InsertEnter",
    },
    -- nvim-cmp source: LSP
    {
        "hrsh7th/cmp-nvim-lsp",
        event = "InsertEnter",
    },
    -- nvim-cmp source: current buffer words
    {
        "hrsh7th/cmp-buffer",
        event = "InsertEnter",
    },
    -- nvim-cmp source: file paths
    {
        "hrsh7th/cmp-path",
        event = "InsertEnter",
    },
    -- Treesitter for syntax highlighting and parsing
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile", "BufReadPost" },
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        config = function()
            require("configs.treesitter")
        end,
    },
    -- Extra text objects (functions, loops, blocks) for Treesitter
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "VeryLazy",
        config = function()
            require("configs.treesitter-textobjects")
        end,
    },
    -- Auto-close and auto-rename HTML/JSX tags
    {
        "windwp/nvim-ts-autotag",
        event = "VeryLazy",
        config = function()
            require("nvim-ts-autotag").setup({})
        end,
    },
    -- Powerful fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        opts = function()
            return require("configs.telescope")
        end,
    },
    -- Highlight and manage TODO, FIX, HACK comments
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        config = function()
            require("todo-comments").setup({})
            vim.api.nvim_create_user_command("OpenTelescopeTodoComments", function()
                require("todo-comments").telescope()
            end, {
                desc = "open todo comments in telescope",
                nargs = 0,
            })
            vim.keymap.set("n", "<leader>ft", ":TodoTelescope<CR>", { desc = "todo comments telescope" })
        end,
    },
    -- Lightweight Markdown preview rendered in Neovim buffer
    {
        "MeanderingProgrammer/render-markdown.nvim",
        event = "VeryLazy",
        config = function()
            require("render-markdown").setup({
                enabled = false,
                latex = { enabled = false },
                html = { enabled = false },
            })
            vim.api.nvim_create_user_command("ToggleBufferRenderMarkdown", function()
                require("render-markdown").buf_toggle()
            end, {
                desc = "toggle buffer render markdown preview",
                nargs = 0,
            })
            vim.keymap.set(
                "n",
                "<leader>md",
                ":ToggleBufferRenderMarkdown<CR>",
                { desc = "toggle buffer render markdown" }
            )
        end,
    },
    -- Add/change/delete surrounding characters like parentheses, quotes, etc.
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    -- Integrates LazyGit terminal UI into Neovim
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
        keys = {
            { "<leader>g", "<cmd>LazyGit<cr>", desc = "lazygit" },
        },
    },
    -- Adds a centered command-line popup.
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("noice").setup({
                cmdline = {
                    view = "cmdline_popup",
                },
                messages = {
                    enabled = false,
                },
                notify = {
                    enabled = false,
                },
                lsp = {
                    progress = {
                        enabled = false,
                    },
                    hover = {
                        enabled = false,
                    },
                    signature = {
                        enabled = false,
                    },
                },
                views = {
                    cmdline_popup = {
                        position = {
                            row = "40%",
                            col = "50%",
                        },
                        size = {
                            width = 60,
                            height = "auto",
                        },
                    },
                },
                presets = {},
            })
        end,
    },
}
