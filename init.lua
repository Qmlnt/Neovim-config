require "options"
require "mappings"
require "autocmds"


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system("git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable " .. lazypath)
end
vim.opt.rtp:prepend(lazypath)

-- dynamically merge lua/plugins{,/*}.lua to the main plugin spec
require("lazy").setup("plugins", {
    ui = { border = require("assets").border },
    change_detection = { notify = false }
})
