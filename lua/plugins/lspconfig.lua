return {
    "neovim/nvim-lspconfig",
    lazy = true,
    opts = {
        diagnostics = { -- :h vim.diagnostic.config()
            underline = true,
            virtual_text = {
                severity = { min = vim.diagnostic.severity.INFO },
                source = "if_many",
                spacing = 4,
                --[[prefix = function(diagnostics)
                    return ({ "⤬", "!", "󰙎", "󱠃" })[diagnostics.severity] or "?"
                end,]]
            },
            signs = { text = { "⤬", "!", "󰙎", "󱠃" } }, -- E, W, I, H
            float = { border = require("assets").border_bleed },
            update_in_insert = false,
            severity_sort = true,
        },
        default_lspconfig = {
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
    },

    config = function(_, opts)
        vim.diagnostic.config(opts.diagnostics)

        require("lspconfig.ui.windows").default_options.border = require("assets").border -- :LspInfo
        local lspconfig = require("lspconfig")
        lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, opts.default_lspconfig)

        local map = vim.keymap.set -- TODO? codelens

        vim.api.nvim_create_autocmd("LspAttach", { -- only when LSP server available
            callback = function(args)
                vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc" -- <c-x><c-o>
                map("n", "gd", vim.lsp.buf.definition, { buffer = args.buf })
                map("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf })
            end,
        })
        --vim.api.nvim_create_autocmd("CursorHold",  { callback = vim.lsp.buf.document_highlight })
        --vim.api.nvim_create_autocmd("CursorMoved", { callback = vim.lsp.buf.clear_references })

        -- diagnostics
        map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
        map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
        map("n", "<Leader>lgs", vim.diagnostic.show,    { desc = "Show" })
        map("n", "<Leader>lgh", vim.diagnostic.hide,    { desc = "Hide" })
        map("n", "<Leader>lge", vim.diagnostic.enable,  { desc = "Enable" })
        map("n", "<Leader>lgd", vim.diagnostic.disable, { desc = "Disable" })
        map("n", "<Leader>lo",  vim.diagnostic.open_float, { desc = "Floating diagnostics" })
        map("n", "<Leader>ll",  vim.diagnostic.setloclist, { desc = "Location list (local)" })
        map("n", "<Leader>lq",  vim.diagnostic.setqflist,  { desc = "Quickfix list (global)" })
        --      LSP
        map("n", "<Leader>lh", vim.lsp.buf.hover,               { desc = "Hover" })
        map("n", "<Leader>ln", vim.lsp.buf.rename,              { desc = "Rename" })
        map("n", "<Leader>ld", vim.lsp.buf.definition,          { desc = "Definition" })
        map("n", "<Leader>lD", vim.lsp.buf.declaration,         { desc = "Declaration" })
        map("n", "<Leader>lt", vim.lsp.buf.type_definition,     { desc = "Type definition" })
        map("n", "<Leader>li", vim.lsp.buf.implementation,      { desc = "Implementation" })
        map("n", "<Leader>lr", vim.lsp.buf.references,          { desc = "References" })
        map("n", "<Leader>lv", vim.lsp.buf.document_highlight,  { desc = "Highlight references" })
        map("n", "<Leader>lV", vim.lsp.buf.clear_references,    { desc = "Clear highlight" })
        map("n", "<Leader>lQ", vim.lsp.buf.document_symbol,     { desc = "Quickfix of keywords" })
        map("n", "<Leader>ls", vim.lsp.buf.signature_help,      { desc = "Signature help" })
        map("n", "<Leader>lI", vim.lsp.buf.incoming_calls,      { desc = "Incoming calls" })
        map("n", "<Leader>lO", vim.lsp.buf.outgoing_calls,      { desc = "Outgoing calls" })
        map({ "n", "x" }, "<Leader>la", vim.lsp.buf.code_action, { desc = "Code action" })
        map({ "n", "x" }, "<Leader>lf", function() vim.lsp.buf.format { async = true } end, { desc = "Format" })
        map("n", "<Leader>lc", function()
            vim.lsp.util.open_floating_preview(
                { vim.lsp.semantic_tokens.get_at_pos()[1].type },
                nil,
                { border = require("assets").border_bleed })
        end, { desc = "Type under cursor" })
        -- workspace
        map("n", "<Leader>lR", vim.lsp.buf.workspace_symbol, { desc = "Workspace references" })
        map("n", "<Leader>lw", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace" })
        map("n", "<Leader>lW", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace" })
        map("n", "<Leader>lL", function()
            vim.print(vim.lsp.buf.list_workspace_folders())
        end, { desc = "List folders" })
    end
}
