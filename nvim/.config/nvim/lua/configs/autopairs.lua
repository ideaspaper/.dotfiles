local M = {}

M.opts = {
    fast_wrap = {},
    disable_filetype = { "TelescopePrompt", "vim" },
}

function M.setup()
    local autopairs = require("nvim-autopairs")
    autopairs.setup(M.opts)

    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
