require "options"
require "mappings"
require "autocmds"

definition = vim.lsp.buf.definition
print(vim.lsp.buf.declaraction)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system("git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable " .. lazypath)
end
vim.opt.rtp:prepend(lazypath)

-- dynamically merge lua/plugins{,/*}.lua to the main plugin spec
require("lazy").setup("plugins", {
    ui = { border = "single" }, -- :h nvim_open_win
    change_detection = { notify = false }
})
