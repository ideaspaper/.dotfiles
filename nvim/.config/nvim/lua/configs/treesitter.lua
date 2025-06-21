pcall(function()
    dofile(vim.g.base46_cache .. "syntax")
    dofile(vim.g.base46_cache .. "treesitter")
end)

local options = {
    ensure_installed = {
        "bash",
        "fish",
        "yaml",
        "json",
        "toml",
        "markdown",
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "gowork",
        "make",
        "printf",
        "javascript",
        "typescript",
        "tsx",
        "vim",
        "vimdoc",
        "lua",
        "luadoc",
    },

    highlight = {
        enable = true,
        use_languagetree = true,
    },

    indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)
