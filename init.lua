require "assets"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system("git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable " .. lazypath)
end
vim.opt.rtp:prepend(lazypath)

-- Stop loading if opening a .gpg file
for _, arg in ipairs(vim.v.argv) do
    if arg:match("%.gpg$") then
        return
    end
end

-- Dynamically merge lua/plugins{,/*}.lua to the main plugin spec
require("lazy").setup("plugins", {
    defaults = { lazy = true },
    change_detection = { notify = false },
    ui = { border = require("assets.assets").border }
})
