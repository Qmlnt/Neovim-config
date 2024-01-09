local M = {
    "neovim/nvim-lspconfig",
    lazy = true,
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
    float = { border = require("assets").border_bleed },
}

local lspconfig_overrides = {
    handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = require("assets").border_bleed, max_width = 80
        }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = require("assets").border_bleed, max_width = 80
        })
    },
    capabilities = require("assets").protected_require("cmp_nvim_lsp",
        function(cmp) return cmp.default_capabilities() end)
}


local function setup_mappings()
    local map = vim.keymap.set -- TODO? codelens
    local diag = vim.diagnostic
    local lsp = vim.lsp.buf

    -- Overrides of default keymaps
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc" -- <c-x><c-o>
            map("n", "gd", lsp.definition, { buffer = args.buf })
            map("n", "gD", lsp.declaration, { buffer = args.buf })
        end
    })
    --vim.api.nvim_create_autocmd("CursorHold",  { callback = lsp.document_highlight })
    --vim.api.nvim_create_autocmd("CursorMoved", { callback = lsp.clear_references })

    -- Diagnostics
    map("n", "]d", diag.goto_next, { desc = "Next diagnostic" })
    map("n", "[d", diag.goto_prev, { desc = "Prev diagnostic" })
    map("n", "<Leader>lgs", diag.show,    { desc = "Show" })
    map("n", "<Leader>lgh", diag.hide,    { desc = "Hide" })
    map("n", "<Leader>lge", diag.enable,  { desc = "Enable" })
    map("n", "<Leader>lgd", diag.disable, { desc = "Disable" })
    map("n", "<Leader>lo",  diag.open_float, { desc = "Floating diagnostics" })
    map("n", "<Leader>ll",  diag.setloclist, { desc = "Location list (local)" })
    map("n", "<Leader>lq",  diag.setqflist,  { desc = "Quickfix list (global)" })

    -- LSP
    map("n", "<Leader>lh", lsp.hover,               { desc = "Hover" })
    map("n", "<Leader>ln", lsp.rename,              { desc = "Rename" })
    map("n", "<Leader>ld", lsp.definition,          { desc = "Definition" })
    map("n", "<Leader>lD", lsp.declaration,         { desc = "Declaration" })
    map("n", "<Leader>lt", lsp.type_definition,     { desc = "Type definition" })
    map("n", "<Leader>li", lsp.implementation,      { desc = "Implementation" })
    map("n", "<Leader>lr", lsp.references,          { desc = "References" })
    map("n", "<Leader>lv", lsp.document_highlight,  { desc = "Highlight references" })
    map("n", "<Leader>lV", lsp.clear_references,    { desc = "Clear highlight" })
    map("n", "<Leader>lQ", lsp.document_symbol,     { desc = "Quickfix of keywords" })
    map("n", "<Leader>ls", lsp.signature_help,      { desc = "Signature help" })
    map("n", "<Leader>lI", lsp.incoming_calls,      { desc = "Incoming calls" })
    map("n", "<Leader>lO", lsp.outgoing_calls,      { desc = "Outgoing calls" })
    map({ "n", "x" }, "<Leader>la", lsp.code_action, { desc = "Code action" })
    map({ "n", "x" }, "<Leader>lf", function() lsp.format { async = true } end, { desc = "Format" })
    map("n", "<Leader>lc", function() vim.lsp.util.open_floating_preview(
            { vim.lsp.semantic_tokens.get_at_pos()[1].type },
            nil, { border = require("assets").border_bleed })
    end, { desc = "Type under cursor" })
    -- Workspace
    map("n", "<Leader>lR", lsp.workspace_symbol, { desc = "Workspace references" })
    map("n", "<Leader>lw", lsp.add_workspace_folder, { desc = "Add workspace" })
    map("n", "<Leader>lW", lsp.remove_workspace_folder, { desc = "Remove workspace" })
    map("n", "<Leader>lL", function() vim.print(lsp.list_workspace_folders())
    end, { desc = "List folders" })
end


function M.config()
    local lspconfig = require("lspconfig")
    lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, lspconfig_overrides)

    vim.diagnostic.config(diagnostic_config)
    require("lspconfig.ui.windows").default_options.border = require("assets").border -- :LspInfo

    setup_mappings()
end

return M
