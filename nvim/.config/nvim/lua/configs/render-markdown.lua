local M = {}

function M.setup()
    local markdown = require("render-markdown")

    markdown.setup({
        enabled = false,
        latex = { enabled = false },
        html = { enabled = false },
    })

    vim.api.nvim_create_user_command("ToggleBufferRenderMarkdown", function()
        markdown.buf_toggle()
    end, {
        desc = "toggle buffer render markdown preview",
        nargs = 0,
    })

    vim.keymap.set("n", "<leader>md", "<cmd>ToggleBufferRenderMarkdown<CR>", {
        desc = "toggle buffer render markdown",
    })
end

return M
