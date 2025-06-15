return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("configs.treesitter")
		end,
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				config = function()
					require("configs.treesitter-textobjects")
				end,
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvchad.configs.lspconfig").defaults()
			require("configs.lspconfig")
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lspconfig" },
		config = function()
			require("configs.mason-lspconfig")
		end,
	},
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup({})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter" },
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-telescope/telescope.nvim" },
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
	{
		"MeanderingProgrammer/render-markdown.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		config = function()
			require("render-markdown").setup({
				enabled = false,
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
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
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
						{ desc = "inner hunk text object", buffer = bufnr }
					)
					vim.keymap.set(
						{ "o", "x" },
						"ah",
						":<C-U>Gitsigns select_hunk<CR>",
						{ desc = "around hunk text object", buffer = bufnr }
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
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
	},
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
		keys = {
			{ "<leader>g", "<cmd>LazyGit<cr>", desc = "lazygit" },
		},
	},
}
