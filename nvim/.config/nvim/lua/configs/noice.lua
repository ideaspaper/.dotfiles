local M = {}

function M.setup()
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
            progress = { enabled = false },
            hover = { enabled = false },
            signature = { enabled = false },
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
end

return M
