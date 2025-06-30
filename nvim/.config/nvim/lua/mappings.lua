local map = vim.keymap.set

-- Disable arrow keys
map({ "n", "i", "v", "c", "t" }, "<Up>", "<Nop>", { desc = "disable up arrow key" })
map({ "n", "i", "v", "c", "t" }, "<Down>", "<Nop>", { desc = "disable down arrow key" })
map({ "n", "i", "v", "c", "t" }, "<Left>", "<Nop>", { desc = "disable left arrow key" })
map({ "n", "i", "v", "c", "t" }, "<Right>", "<Nop>", { desc = "disable right arrow key" })

-- General
map("n", ";", ":", { desc = "CMD enter command mode" })
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", { desc = "general save file" })
map("i", "jk", "<Esc>", { noremap = true, desc = "exit insert mode using jk" })
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

-- Buffer handling
map("n", "<tab>", function()
    require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<S-tab>", function()
    require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<leader>x", function()
    require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

map("n", "<leader>X", function()
    local current = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if buf ~= current and vim.api.nvim_buf_is_loaded(buf) then
            local buf_ft = vim.api.nvim_buf_get_option(buf, "filetype")
            local buf_name = vim.api.nvim_buf_get_name(buf)
            local is_modified = vim.api.nvim_buf_get_option(buf, "modified")
            local is_terminal = buf_name:match("^term://")

            if buf_ft ~= "NvimTree" and not is_terminal and not is_modified then
                vim.api.nvim_buf_delete(buf, { force = false })
            end
        end
    end
end, { desc = "close all buffers except current and modified" })

-- Format
map({ "n", "x" }, "<leader>fm", function()
    require("conform").format({ lsp_fallback = true })
end, { desc = "general format file" })

-- LSP
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "lsp diagnostic loclist" })

-- NvimTree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })

-- Telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
map("n", "<leader>fc", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
map("n", "<leader>fs", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
    "n",
    "<leader>fa",
    "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
    { desc = "telescope find all files" }
)
map("n", "<leader>th", function()
    require("nvchad.themes").open()
end, { desc = "telescope nvchad themes" })

-- Terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
map({ "n", "t" }, "<A-i>", function()
    require("nvchad.term").toggle({ pos = "float", id = "floatTerm" })
end, { desc = "terminal toggle floating term" })

-- WhichKey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })
map("n", "<leader>wk", function()
    vim.cmd("WhichKey " .. vim.fn.input("WhichKey: "))
end, { desc = "whichkey query lookup" })

-- Open Chrome
vim.api.nvim_create_user_command("OpenChrome", function()
    local file_path = vim.fn.expand("%:p")
    local command = 'open -a "Google Chrome" ' .. vim.fn.shellescape(file_path)
    vim.cmd("silent !" .. command)
end, {
    desc = "\u{f268} open current file in Google Chrome",
    nargs = 0,
})
map("n", "<leader>oc", ":OpenChrome<CR>", { desc = "\u{f268} open in Chrome" })

-- Toggle buffer render markdown
vim.api.nvim_create_user_command("ToggleBufferRenderMarkdown", function()
    require("render-markdown").buf_toggle()
end, {
    desc = "toggle buffer render markdown preview",
    nargs = 0,
})
map("n", "<leader>md", ":ToggleBufferRenderMarkdown<CR>", { desc = "toggle buffer render markdown" })

-- Toggle line wrapping
map("n", "<leader>wr", ":set wrap!<CR>", { desc = "toggle word wrap" })
