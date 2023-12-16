vim.g.mapleader = " " -- must be before any plugins
vim.g.maplocalleader = " "

-- TODO window keymaps with Leader

vim.keymap.set("n", "<Leader>nw", vim.cmd.Ex)

-- clipboard stuff
vim.keymap.set(  "x",        "<Leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<Leader>d", [["_d]])
vim.keymap.set({ "n", "v" }, "<Leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<Leader>Y", [["+Y]])

-- lock the cursor at one place
vim.keymap.set("n", "J", "mjJ`j")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
