return {
    "neovim/nvim-lspconfig",
    lazy = true,
    opts = {
        diagnostics = { -- :h vim.diagnostic.config()
            underline = true,
            virtual_text = {
                source = "if_many",
                spacing = 4,
                prefix = "󱈸",
                --prefix = "icons", -- TODO in NVIM v10
            },
            float = { border = "single" },
            update_in_insert = false,
            severity_sort = true,
        },
    },

    config = function(_, opts)
        require("lspconfig.ui.windows").default_options.border = "single" -- :LspInfo
        -- diagnositcs
        vim.diagnostic.config(opts.diagnostics)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
        vim.keymap.set("n", "<Leader>ls", vim.diagnostic.show, { desc = "Show diagnostics" })
        vim.keymap.set("n", "<Leader>lh", vim.diagnostic.hide, { desc = "Hide diagnostics" })
        vim.keymap.set("n", "<Leader>le", vim.diagnostic.enable, { desc = "Enable diagnostics" })
        vim.keymap.set("n", "<Leader>ld", vim.diagnostic.disable, { desc = "Disable diagnostics" })
        vim.keymap.set("n", "<Leader>lf", vim.diagnostic.open_float, { desc = "Floating diagnostics" })
        vim.keymap.set("n", "<Leader>ll", vim.diagnostic.setloclist, { desc = "Location list (local)" })
        vim.keymap.set("n", "<Leader>lq", vim.diagnostic.setqflist, { desc = "Quickfix list (global)" })
    end
}
