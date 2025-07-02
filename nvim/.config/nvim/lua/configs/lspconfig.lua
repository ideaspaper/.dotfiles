local M = {}
local map = vim.keymap.set

M.on_attach = function(client, bufnr)
    local function opts(desc)
        return { buffer = bufnr, desc = "lsp " .. desc }
    end

    map("n", "gD", vim.lsp.buf.declaration, opts("go to declaration"))
    map("n", "gd", vim.lsp.buf.definition, opts("go to definition"))
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("add workspace folder"))
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("remove workspace folder"))

    map("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts("list workspace folders"))

    map("n", "<leader>D", vim.lsp.buf.type_definition, opts("go to type definition"))
    map("n", "<leader>rn", vim.lsp.buf.rename, opts("rename"))

    if client.server_capabilities.documentHighlightProvider then
        local group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = false })
        vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })

        vim.api.nvim_create_autocmd("CursorHold", {
            group = group,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.document_highlight()
            end,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
            group = group,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.clear_references()
            end,
        })
    end
end

M.on_init = function(client, _)
    if client.supports_method("textDocument/semanticTokens") then
        client.server_capabilities.semanticTokensProvider = nil
    end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}

M.defaults = function()
    dofile(vim.g.base46_cache .. "lsp")
    require("nvchad.lsp").diagnostic_config()

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            local bufnr = args.buf
            M.on_attach(client, bufnr)
        end,
    })

    local lspconfig = require("lspconfig")

    local default_servers = {
        "lua_ls",
        "gopls",
        "ts_ls",
        "pylsp",
        "jsonls",
        "yamlls",
    }

    for _, lsp in ipairs(default_servers) do
        lspconfig[lsp].setup({
            on_attach = M.on_attach,
            on_init = M.on_init,
            capabilities = M.capabilities,
        })
    end

    lspconfig.lua_ls.setup({
        on_attach = M.on_attach,
        on_init = M.on_init,
        capabilities = M.capabilities,
        settings = {
            Lua = {
                diagnostics = {
                    enable = false,
                },
                workspace = {
                    library = {
                        vim.fn.expand("$VIMRUNTIME/lua"),
                        vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                        vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
                        vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
                        "${3rd}/love2d/library",
                    },
                    maxPreload = 100000,
                    preloadFileSize = 10000,
                },
            },
        },
    })
end

return M
