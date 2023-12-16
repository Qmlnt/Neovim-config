vim.g.mapleader = " " -- must be before any plugins
vim.g.maplocalleader = " "
local map = vim.keymap.set

map("n", "<Leader>nw", vim.cmd.Ex)
map("n", "<C-i>", "<C-i>") -- jump list

-- clipboard stuff
map("x", "<Leader>p", [["_dP]])
map({ "n", "v" }, "<Leader>d", [["_d]])
map({ "n", "v" }, "<Leader>y", [["+y]])
map({ "n", "v" }, "<Leader>Y", [["+Y]])

-- up/down on wrapped lines
map({ "n", "x" }, "<Down>", "j", { remap = true })
map({ "n", "x" }, "<Up>",   "k", { remap = true })
map({ "n", "x" }, "j", [[v:count == 0 ? "gj" : "j"]], { expr = true })
map({ "n", "x" }, "k", [[v:count == 0 ? "gk" : "k"]], { expr = true })

-- lock the cursor at the center
map("n", "J", "mjJ`j")
map("n", "n", "nzvzz")
map("n", "N", "Nzvzz")
map("n", "*", "*zvzz")
map("n", "#", "#zvzz")
map("n", "g*", "g*zvzz")
map("n", "g#", "g#zvzz")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "<S-Up>", ":move '>+1<CR>gv=gv")
map("v", "<S-Down>", ":move '<-2<CR>gv=gv")


-- window navigation
map("n", "<C-Down>",  "<C-j>", { remap = true })
map("n", "<C-Up>",    "<C-k>", { remap = true })
map("n", "<C-Left>",  "<C-h>", { remap = true })
map("n", "<C-Right>", "<C-l>", { remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Upper window" })
map("n", "<C-h>", "<C-w>h", { desc = "Left window"  })
map("n", "<C-l>", "<C-w>l", { desc = "Right window" })
-- window resizing
map("n", "<A-Down>",  "<A-j>", { remap = true })
map("n", "<A-Up>",    "<A-k>", { remap = true })
map("n", "<A-Left>",  "<A-h>", { remap = true })
map("n", "<A-Right>", "<A-l>", { remap = true })
map("n", "<A-j>", "<Cmd>resize -2<CR>", { desc = "Increase height" })
map("n", "<A-k>", "<Cmd>resize +2<CR>", { desc = "Decrease height" })
map("n", "<A-h>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease width" })
map("n", "<A-l>", "<Cmd>vertical resize +2<CR>", { desc = "Increase width" })
