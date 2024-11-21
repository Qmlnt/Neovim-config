--[[
TODO:
* make a plugin state table for each buffer
* what TO DO if also editing the file externally? have a decrypt fn?
* query for encryption parameters and be smart
* support key decryption & encryption
* write commands to manage parameters
MAYBE:
* be able to encrypt into binary? (bin decription works using file path and not buf contents)
* make fancy windows? why tho
AT LEAST TRY:
* ediding encrypted tar files. (is tar plugin even in Lua yet?)
]]

local function set_gpg_encrypt(passphrase)
    -- Encrypt text within buffer. On error use old cipher.
    vim.b.gpg_encrypt = function()
        local result = vim.system(
            { "/usr/bin/gpg", "--batch", "--armor", "--symmetric", "--cipher-algo", "AES256", "--passphrase", passphrase },
            { env = {}, clear_env = true, stdin = vim.api.nvim_buf_get_lines(0, 0, -1, true), text = true }
        ):wait()

        if result.code == 0 then
            vim.b.backup_encrypted = vim.split(result.stdout, "\n", { trimempty = true })
        else
            vim.notify(result.stderr, vim.log.levels.ERROR)
        end

        vim.api.nvim_buf_set_lines(0, 0, -1, true, vim.b.backup_encrypted or {})
    end
end


local gpg_group = vim.api.nvim_create_augroup("custom_gpg", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPre", "FileReadPre" }, {
    pattern = { "*.gpg", "*.asc" },
    group = gpg_group,
    callback = function() -- turn off options that write to disk
        vim.opt_local.shada = ""
        vim.opt_local.swapfile = false
        vim.opt_local.undofile = false
    end,
})

vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
    pattern = { "*.gpg", "*.asc" },
    group = gpg_group,
    callback = function()
        -- if vim.b.gpg_abort then return end

        -- autocmd can't cancel :w, so for error cases using this backup cipher
        vim.b.backup_encrypted = vim.api.nvim_buf_get_lines(0, 0, -1, true)

        while true do
            local passphrase = vim.fn.inputsecret("Enter passphrase to decrypt or 'q' to not: ")
            if passphrase == "q" then
                vim.b.gpg_abort = true
                break
            end

            local result = vim.system(
                { "/usr/bin/gpg", "--batch", "--decrypt", "--passphrase",
                    passphrase, vim.api.nvim_buf_get_name(0) },
                { env = {}, clear_env = true, text = true }
            ):wait()

            if result.code == 0 then
                vim.api.nvim_buf_set_lines(0, 0, -1, true, vim.split(result.stdout:gsub("\n$", ""), "\n"))
                set_gpg_encrypt(passphrase)
                break
            end

            vim.notify(result.stderr, vim.log.levels.ERROR)
        end

        -- Execute BufReadPost without .gpg in filename
        vim.api.nvim_exec_autocmds("BufReadPost", { pattern = vim.fn.expand("%:r") })
    end,
})

-- Encrypt all text in buffer before writing
vim.api.nvim_create_autocmd({ "BufWritePre", "FileWritePre" }, {
    pattern = { "*.gpg", "*.asc" },
    group = gpg_group,
    callback = function()
        if vim.b.gpg_abort then
            return
        end

        if vim.b.gpg_encrypt then
            vim.b.gpg_encrypt()
            return
        end

        vim.notify("Need passphrase to encrypt new file.", vim.log.levels.INFO)
        while true do
            local passphrase = vim.fn.inputsecret("Enter passphrase for encryption or 'q' to abort: ")
            if passphrase == "q" then
                vim.api.nvim_buf_set_lines(0, 0, -1, true, {}) -- can't stop writing operation
                return
            end

            local passphrase2 = vim.fn.inputsecret("Repeat passphrase or 'q' to abort: ")
            if passphrase2 == "q" then
                vim.api.nvim_buf_set_lines(0, 0, -1, true, {}) -- can't stop writing operation
                return
            end

            if passphrase == passphrase2 then
                set_gpg_encrypt(passphrase)
                vim.b.gpg_encrypt()
                break
            end
            vim.notify("\nPassphrases do not match!", vim.log.levels.WARN)
        end
    end,
})
-- Undo the encryption in buffer after the file has been written
vim.api.nvim_create_autocmd({ "BufWritePost", "FileWritePost" }, {
    pattern = { "*.gpg", "*.asc" },
    group = gpg_group,
    command = ":silent u",
})
