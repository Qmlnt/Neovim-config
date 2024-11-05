vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank() end
})

-- Doesn't trigger for manpages
vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "BufNewFile" }, {
    callback = vim.schedule_wrap(function()
        vim.api.nvim_exec_autocmds("User", { pattern = "LazyFile" })
        vim.schedule_wrap(vim.api.nvim_exec_autocmds)("User", { pattern = "VeryLazyFile" })
    end)
})

vim.api.nvim_create_autocmd("LspAttach", {                   -- Overrides the default keymaps
    callback = function(args)
        vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc" -- <c-x><c-o>
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = args.buf })
    end
})
--vim.api.nvim_create_autocmd("CursorHold",  { callback = lsp.document_highlight })
--vim.api.nvim_create_autocmd("CursorMoved", { callback = lsp.clear_references })
