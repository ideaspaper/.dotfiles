dofile(vim.g.base46_cache .. "git")

local M = {}

M.opts = {
    signs = {
        delete = { text = "󰍵" },
        changedelete = { text = "󱕖" },
    },
}

M.on_attach = function(bufnr)
    local gs = require("gitsigns")
    local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { desc = desc, buffer = bufnr })
    end

    map("n", "]c", gs.next_hunk, "next hunk")
    map("n", "[c", gs.prev_hunk, "prev hunk")
    map("n", "<leader>cs", gs.stage_hunk, "stage hunk")
    map("n", "<leader>cu", gs.undo_stage_hunk, "undo stage hunk")
    map("n", "<leader>cr", gs.reset_hunk, "reset hunk")
    map("n", "<leader>cp", gs.preview_hunk, "preview hunk")
    map("n", "<leader>cB", function()
        gs.blame_line({ full = true })
    end, "blame line")
    map("n", "<leader>cD", gs.diffthis, "diff this")
    map("n", "<leader>cS", ":Gitsigns stage_buffer<CR>", "stage buffer")
    map("n", "<leader>cU", ":Gitsigns reset_buffer<CR>", "reset buffer")

    map("v", "<leader>cs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, "stage selection")
    map("v", "<leader>gr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, "reset selection")

    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "inner hunk")
    map({ "o", "x" }, "ah", ":<C-U>Gitsigns select_hunk<CR>", "around hunk")
    map("n", "<leader>cb", gs.toggle_current_line_blame, "toggle blame")
end

return M
