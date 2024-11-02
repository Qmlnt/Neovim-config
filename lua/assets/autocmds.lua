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


local gpg_group = vim.api.nvim_create_augroup("custom_gpg", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
    pattern = {"*.gpg", "*.asc"},
    group = gpg_group,
    callback = function()
        vim.opt_local.shada = nil      -- turn off shada file
        vim.opt_local.swapfile = false -- don't write unencrypted data to disk
        vim.opt_local.bin = true       -- binary mode to read encrypted file
        vim.opt_local.undofile = false -- don't write undo history to disk

        -- vim.b.ch_save = vim.opt_local.ch -- save cmdheight
        vim.cmd "set ch=2"               -- avoid hit-enter prompts
    end,
})
vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
    pattern = {"*.gpg", "*.asc"},
    group = gpg_group,
    callback = function()
        vim.cmd("'[,']!gpg --decrypt --batch --passphrase \""
            .. vim.fn.inputsecret("Enter passphrase to decrypt: ")
            .. "\" 2> /dev/null")

        vim.opt_local.bin = false -- normal mode for editing

        -- Restore cmdheight from buffer variable
        vim.cmd "set ch=1"               -- avoid hit-enter prompts
        vim.opt_local.ch = vim.b.ch_save
        -- vim.cmd "unlet b:ch_save"

        -- Execute BufReadPost without .gpg in filename
        vim.api.nvim_exec_autocmds("BufReadPost", { pattern = vim.fn.expand("%:r") })
    end,
})

-- Encrypt all text in buffer before writing
vim.api.nvim_create_autocmd({ "BufWritePre", "FileWritePre" }, {
    pattern = {"*.gpg", "*.asc"},
    group = gpg_group,
    -- TODO: ask how to encrypt and which key to use
    callback = function()
        vim.cmd("'[,']!gpg --symmetric --cipher-algo AES256 --armour --batch --passphrase \""
        .. vim.fn.inputsecret("Enter passphrase to encrypt: ")
        .. "\" 2> /dev/null")
    end,
    -- command = "'[,']!gpg --default-recipient-self -ae 2>/dev/null",
})
-- Undo the encryption in buffer after the file has been written
vim.api.nvim_create_autocmd({ "BufWritePost", "FileWritePost" }, {
    pattern = {"*.gpg", "*.asc"},
    group = gpg_group,
    command = "u",
})
