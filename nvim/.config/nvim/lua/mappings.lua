require("nvchad.mappings")

local map = vim.keymap.set

-- disable arrow keys
map({ "n", "i", "v", "c", "t" }, "<Up>", "<Nop>", { desc = "disable up arrow key" })
map({ "n", "i", "v", "c", "t" }, "<Down>", "<Nop>", { desc = "disable down arrow key" })
map({ "n", "i", "v", "c", "t" }, "<Left>", "<Nop>", { desc = "disable left arrow key" })
map({ "n", "i", "v", "c", "t" }, "<Right>", "<Nop>", { desc = "disable right arrow key" })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- emacs style keybindings
-- vim.keymap.set('i', '<C-b>', '<Left>', { silent = true, desc = 'move left' })
-- vim.keymap.set('i', '<C-f>', '<Right>', { silent = true, desc = 'move right' })
-- vim.keymap.set('i', '<A-b>', '<S-Left>', { silent = true, desc = 'word left' })
-- vim.keymap.set('i', '<A-f>', '<S-Right>', { silent = true, desc = 'word right' })
-- vim.keymap.set('i', '<C-a>', '<Esc>^i', { silent = true, desc = 'line start' })
-- vim.keymap.set('i', '<C-e>', '<Esc>A', { silent = true, desc = 'line end' })
-- vim.keymap.set('i', '<C-d>', '<Del>', { silent = true, desc = 'delete char' })
-- vim.keymap.set('i', '<C-h>', '<BS>', { silent = true, desc = 'backspace' })
-- vim.keymap.set('i', '<C-u>', '<C-u>', { silent = true, desc = 'cut to start' })
-- vim.keymap.set('i', '<C-k>', '<Esc>Dli', { silent = true, desc = 'cut to end' })
-- vim.keymap.set('i', '<C-w>', '<C-w>', { silent = true, desc = 'cut word back' })
-- vim.keymap.set('i', '<A-d>', '<Esc>dawlbi', { silent = true, desc = 'cut word fwd' })

-- open chrome
vim.api.nvim_create_user_command("OpenChrome", function()
	local file_path = vim.fn.expand("%:p")
	local command = 'open -a "Google Chrome" ' .. vim.fn.shellescape(file_path)
	vim.cmd("silent !" .. command)
end, {
	desc = "\u{f268} open current file in Google Chrome",
	nargs = 0,
})

vim.keymap.set("n", "<leader>oc", ":OpenChrome<CR>", { desc = "\u{f268} open in Chrome" })

-- toggle buffer render markdown
vim.api.nvim_create_user_command("ToggleBufferRenderMarkdown", function()
	require("render-markdown").buf_toggle()
end, {
	desc = "toggle buffer render markdown preview",
	nargs = 0,
})

vim.keymap.set("n", "<leader>md", ":ToggleBufferRenderMarkdown<CR>", { desc = "toggle buffer render markdown" })

-- toggle line wrapping
vim.keymap.set("n", "<leader>wr", ":set wrap!<CR>", { desc = "toggle word wrap" })
