vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank() end
})

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "BufNewFile" }, {
    callback = vim.schedule_wrap(function()
        vim.api.nvim_exec_autocmds("User", { pattern = "HalfLazy" })
    end)
})

--[[vim.api.nvim_create_autocmd("User", {
    pattern = "HalfLazy",
    callback = function() print("LazyFile") end
})]]
