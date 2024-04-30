local lspconfig = require "lspconfig"

vim.diagnostic.config {
    underline = true,
    virtual_text = {
        spacing = 4,
        source = "if_many",
        severity = { min = vim.diagnostic.severity.INFO },
        -- prefix = function(diagnostics)
        --    return ({ "⤬", "!", "󰙎", "󱠃" })[diagnostics.severity] or "?"
        -- end
    },
    severity_sort = true,
    update_in_insert = false,
    signs = { text = { "⤬", "!", "󰙎", "󱠃" } }, -- E, W, I, H
    float = { border = require("assets.assets").border_bleed },
}

lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, {
    handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = require("assets.assets").border_bleed, max_width = 80
        }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = require("assets.assets").border_bleed, max_width = 80
        })
    },
    capabilities = pcall(require, "cmp_nvim_lsp") and
        package.loaded.cmp_nvim_lsp.default_capabilities() or nil
})

require("lspconfig.ui.windows").default_options.border = require("assets.assets").border -- :LspInfo
