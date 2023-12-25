return {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-lspconfig.nvim" },
    lazy = false,
    opts = {
        diagnostics = { -- :h vim.diagnostic.config()
            underline = true,
            virtual_text = {
                source = "if_many",
                spacing = 4,
                prefix = "󱈸",
                --prefix = "icons", -- TODO in NVIM v10
            },
            float = { -- :h vim.lsp.util.open_floating_preview()
                border = "single",
            }, -- TODO :h vim.diagnostic.open_float()
            update_in_insert = false,
            severity_sort = true,
        },
    },

    config = function(_, opts)
        vim.diagnostic.config(opts.diagnostics)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
        vim.keymap.set("n", "<Leader>lh", vim.diagnostic.hide)
        vim.keymap.set("n", "<Leader>le", vim.diagnostic.enable)
        vim.keymap.set("n", "<Leader>ld", vim.diagnostic.disable)
        vim.keymap.set("n", "<Leader>la", function() vim.diagnostic.open_float({ scope = "buffer" }) end) -- TODO: make more fancy
        vim.keymap.set("n", "<Leader>lf", vim.diagnostic.open_float)
    end
}
