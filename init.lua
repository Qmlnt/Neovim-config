require "assets"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system("git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable " .. lazypath)
end
vim.opt.rtp:prepend(lazypath)

-- dynamically merge lua/specs{,/*}.lua to the main plugin spec
require("lazy").setup("specs", {
    change_detection = { notify = false },
    ui = { border = require("assets.assets").border }
})
