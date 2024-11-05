require "utils" -- global functions here
require "options"
require "autocmds"
vim.schedule_wrap(require) "mappings" -- Mappings hog startup time.

-- Stop loading if opening an encrypted file
if require "gpg" then
    return
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system("git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable " .. lazypath)
end
vim.opt.rtp:prepend(lazypath)

-- Dynamically merge lua/plugins{,/*}.lua to the main plugin spec
require("lazy").setup("plugins", {
    defaults = { lazy = true },
    change_detection = { notify = false },
    ui = { border = vim.g.border }
})
