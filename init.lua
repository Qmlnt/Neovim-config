vim.g.mapleader = ' ' -- must be before any plugins
vim.g.maplocalleader = ' '
vim.o.langmap = 'hi,HI,jJ,JK,ko,KO,le,LE,nj,Nn,ek,EN,ih,IH,ol,OL'

vim.o.undofile = true
vim.o.clipboard = 'unnamedplus'
vim.o.wrap = false
vim.o.autoindent = true
vim.o.mouse = 'a'
vim.o.expandtab = true
vim.o.cursorline = true
vim.o.smarttab = true
vim.o.number = true
vim.o.swapfile = true -- :)
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4



local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup {
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- for priority to work
    priority = 1000, -- load before all other start plugins
    --opts = { style = "night" },
    config = function() vim.cmd.colorscheme "tokyonight-night" end
  },

  { "navarasu/onedark.nvim", lazy = true },

  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime", -- lazy-load on a command
    -- init is called during startup. Configuration for vim plugins typically should be set in an init function
    init = function() vim.g.startuptime_tries = 10 end
  },


}



-- vim: ts=2 sts=2 sw=2 et
