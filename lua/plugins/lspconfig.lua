local M = {
    "neovim/nvim-lspconfig",
    lazy = true
}

local diagnostic_config = { -- :h vim.diagnostic.config()
    underline = true,
    virtual_text = {
        spacing = 4,
        source = "if_many",
        severity = { min = vim.diagnostic.severity.INFO },
        --prefix = function(diagnostics)
        --    return ({ "⤬", "!", "󰙎", "󱠃" })[diagnostics.severity] or "?"
        --end
    },
    severity_sort = true,
    update_in_insert = false,
    signs = { text = { "⤬", "!", "󰙎", "󱠃" } }, -- E, W, I, H
    float = { border = require("assets.assets").border_bleed },
}

local lspconfig_overrides = {
    handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = require("assets.assets").border_bleed, max_width = 80
        }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = require("assets.assets").border_bleed, max_width = 80
        })
    },
    capabilities = require("assets.utils").protected_require("cmp_nvim_lsp",
        function(cmp) return cmp.default_capabilities() end)
}


function M.config()
    vim.diagnostic.config(diagnostic_config)

    local lspconfig = require("lspconfig")
    lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, lspconfig_overrides)

    require("lspconfig.ui.windows").default_options.border = require("assets.assets").border -- :LspInfo
end

return M
