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
        default_config = {
            --on_attach = function(_, bufnr) -- TODO?
            --    -- poke vim.o.updatetime for faster highlinght
            --    vim.api.nvim_create_autocmd("CursorHold", {
            --        group = vim.api.nvim_create_augroup("UserLSPHighlight", {}),
            --        --buffer = bufnr,
            --        callback = function() vim.lsp.buf.document_highlight() end
            --    })
            --    vim.api.nvim_create_autocmd("CursorHold", {
            --        group = "UserLSPHighlight",
            --        --buffer = bufnr,
            --        callback = function() vim.lsp.buf.clear_references() end
            --    })
            --end,
            handlers = {
                ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
            }
        }
    },

    config = function(_, opts)
        vim.diagnostic.config(opts.diagnostics)
        require("lspconfig.ui.windows").default_options.border = "single" -- :LspInfo

        local lspconfig = require("lspconfig")
        lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, opts.default_config)
        --vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })


        local map = vim.keymap.set
        -- diagnostics
        map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
        map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
        map("n", "<Leader>lgs", vim.diagnostic.show, { desc = "Show" })
        map("n", "<Leader>lgh", vim.diagnostic.hide, { desc = "Hide" })
        map("n", "<Leader>lge", vim.diagnostic.enable, { desc = "Enable" })
        map("n", "<Leader>lgd", vim.diagnostic.disable, { desc = "Disable" })
        map("n", "<Leader>lo",  vim.diagnostic.open_float, { desc = "Floating diagnostics" })
        map("n", "<Leader>ll",  vim.diagnostic.setloclist, { desc = "Location list (local)" })
        map("n", "<Leader>lq",  vim.diagnostic.setqflist, { desc = "Quickfix list (global)" })
        -- LSP
        map("n", "<Leader>lh", vim.lsp.buf.hover, { desc = "Hover" })
        map("n", "<Leader>ln", vim.lsp.buf.rename, { desc = "Rename" })
        map("n", "<Leader>ld", vim.lsp.buf.definition, { desc = "Definition" })
        map("n", "<Leader>lD", vim.lsp.buf.declaration, { desc = "Declaration" })
        map("n", "<Leader>lt", vim.lsp.buf.type_definition, { desc = "Type definition" })
        map("n", "<Leader>li", vim.lsp.buf.implementation, { desc = "Implementation" })
        map("n", "<Leader>lr", vim.lsp.buf.references, { desc = "References" })
        map("n", "<Leader>lV", vim.lsp.buf.clear_references, { desc = "Clear highlight" })
        map("n", "<Leader>lv", vim.lsp.buf.document_highlight, { desc = "Highlight references" })
        map("n", "<Leader>lQ", vim.lsp.buf.document_symbol, { desc = "Quickfix of symbols" })
        map("n", "<Leader>ls", vim.lsp.buf.signature_help, { desc = "Signature help" })
        map({ "n", "x" }, "<Leader>la", vim.lsp.buf.code_action, { desc = "Code action" })
        map({ "n", "x" }, "<Leader>lf", function() vim.lsp.buf.format { async = true } end, { desc = "Format" })

        map("n", "<Leader>lwa", vim.lsp.buf.add_workspace_folder, { desc = "Add folder" })
        map("n", "<Leader>lwr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove folder" })
        map("n", "<Leader>lwl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { desc = "List folders" })


--       vim.api.nvim_create_autocmd("LspAttach", { -- TODO what's the point of using LspAttach?
--           group = vim.api.nvim_create_augroup("UserLspConfig", {}),
--           callback = function(ev)
--               -- Enable completion triggered by <c-x><c-o>
--               vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

--               local opt = { buffer = ev.buf }
--               map("n", "gD", vim.lsp.buf.declaration, opt)
--               map("n", "gd", vim.lsp.buf.definition, opt)
--               map("n", "K", vim.lsp.buf.hover, opt)
--               map("n", "gi", vim.lsp.buf.implementation, opt)
--               map("n", "<C-k>", vim.lsp.buf.signature_help, opt)
--               map("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, opt)
--               map("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, opt)
--               map("n", "<Leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opt)
--               map("n", "<Leader>D", vim.lsp.buf.type_definition, opt)
--               map("n", "<Leader>rn", vim.lsp.buf.rename, opt)
--               map({ "n", "v" }, "<Leader>ca", vim.lsp.buf.code_action, opt)
--               map("n", "gr", vim.lsp.buf.references, opt)
--               map("n", "<Leader>lf", function() vim.lsp.buf.format { async = true } end, opt)
--           end,
--       })

    end
}
