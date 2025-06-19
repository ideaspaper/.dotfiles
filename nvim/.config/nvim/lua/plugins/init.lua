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

	{
		"nvchad/ui",
		lazy = false,
		config = function()
			require("nvchad")
		end,
	},

	"nvzone/volt",

	{
		"nvim-tree/nvim-web-devicons",
		opts = function()
			dofile(vim.g.base46_cache .. "devicons")
			return { override = require("nvchad.icons.devicons") }
		end,
	},

	-- Indent guides
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "User FilePost",
		opts = {
			indent = { char = "│", highlight = "IblChar" },
			scope = { char = "│", highlight = "IblScopeChar" },
		},
		config = function(_, opts)
			dofile(vim.g.base46_cache .. "blankline")

			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
			require("ibl").setup(opts)

			dofile(vim.g.base46_cache .. "blankline")
		end,
	},

	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		opts = function()
			return require("configs.nvimtree")
		end,
	},

	-- Which-key for keybinding hints
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

	-- Git signs
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

	-- Mason and LSP stuff
	{
		"mason-org/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		opts = function()
			return require("configs.mason")
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile", "User FilePost" },
		config = function()
			require("configs.lspconfig").defaults()
			require("configs.lspconfig")
		end,
	},

	{
		"mason-org/mason-lspconfig.nvim",
		event = "VeryLazy",
		config = function()
			require("configs.mason-lspconfig")
		end,
	},

	-- LuaSnip: Snippet Engine
	{
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		opts = {
			history = true,
			updateevents = "TextChanged,TextChangedI",
		},
		config = function(_, opts)
			local luasnip = require("luasnip")
			luasnip.config.set_config(opts)
			require("configs.luasnip")
		end,
	},

	-- Friendly-snippets: Large snippet collection (loaded separately)
	{
		"rafamadriz/friendly-snippets",
		event = "InsertEnter",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			fast_wrap = {},
			disable_filetype = { "TelescopePrompt", "vim" },
		},
		config = function(_, opts)
			require("nvim-autopairs").setup(opts)
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		opts = function()
			return require("configs.cmp")
		end,
	},

	{
		"saadparwaiz1/cmp_luasnip",
		event = "InsertEnter",
	},
	{
		"hrsh7th/cmp-nvim-lua",
		event = "InsertEnter",
	},
	{
		"hrsh7th/cmp-nvim-lsp",
		event = "InsertEnter",
	},
	{
		"hrsh7th/cmp-buffer",
		event = "InsertEnter",
	},
	{
		"hrsh7th/cmp-path",
		event = "InsertEnter",
	},

	-- Treesitter and related
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile", "BufReadPost" },
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		config = function()
			require("configs.treesitter")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		config = function()
			require("configs.treesitter-textobjects")
		end,
	},

	{
		"windwp/nvim-ts-autotag",
		event = "VeryLazy",
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		opts = function()
			return require("configs.telescope")
		end,
	},

	-- Todo comments
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

	-- Markdown renderer
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

	-- Surround plugin
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	-- LazyGit
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
}
