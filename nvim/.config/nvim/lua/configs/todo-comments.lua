local M = {}

function M.setup()
    local todo = require("todo-comments")

    todo.setup({})

    vim.api.nvim_create_user_command("OpenTelescopeTodoComments", function()
        todo.telescope()
    end, {
        desc = "open todo comments in telescope",
        nargs = 0,
    })

    vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", {
        desc = "todo comments telescope",
    })
end

return M
