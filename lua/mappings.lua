vim.g.mapleader = " " -- must be before any plugins
vim.g.maplocalleader = " "
local map = vim.keymap.set


--      LEADER
-- utilities
map("n", "<Leader>un", vim.cmd.Ex)
map("n", "<Leader>ul", "<Cmd>Lazy<CR>")
map("n", "<Leader>um", "<Cmd>Mason<CR>")
-- toggle stuff
map("n", "<Leader>tw", "<Cmd>set wrap!<CR><Cmd>set wrap?<CR>")
map("n", "<Leader>tc", function() vim.o.colorcolumn=vim.o.colorcolumn=="" and "80" or "" end)
-- clipboard stuff
map("x", "<Leader>p", [["_dP]])
map("n", "<Leader>p", [["+p]])
map({ "n", "v" }, "<Leader>d", [["_d]])
map({ "n", "v" }, "<Leader>y", [["+y]])
map({ "n", "v" }, "<Leader>Y", [["+Y]])
-- buffers
map("n", "<Leader>bn", "<Cmd>bnext<CR>", { desc = "Next" })
map("n", "<Leader>bN", "<Cmd>bprev<CR>", { desc = "Prev" })
map("n", "<Leader>bd", "<Cmd>bdelete<CR>", { desc = "Delete" })
map("n", "<Leader>bu", "<Cmd>bunload<CR>", { desc = "Unload" })
map("n", "<Leader>bp", "<Cmd>buffer#<CR>",   { desc = "Last accessed" })
map("n", "<Leader>bm", "<Cmd>bmodified<CR>", { desc = "Last modified" })
map("n", "<Leader>bh", "<Cmd>sbnext<CR>",        { desc = "H split with next" })
map("n", "<Leader>bH", "<Cmd>sbprev<CR>",        { desc = "H split with prev" })
map("n", "<Leader>bv", "<Cmd>vert sbnext<CR>",   { desc = "V split with next" })
map("n", "<Leader>bV", "<Cmd>vert sbprev<CR>",   { desc = "V split with prev" })
map("n", "<Leader>bs", "<Cmd>vert sbuffer#<CR>", { desc = "V split with last" })
map("n", "<Leader>bS", "<Cmd>sbuffer#<CR>",      { desc = "H split with last" })
-- windows
map("n", "<Leader>w<Down>",  "<C-W>J")
map("n", "<Leader>w<Up>",    "<C-W>K")
map("n", "<Leader>w<Left>",  "<C-W>H")
map("n", "<Leader>w<Right>", "<C-W>L")
map("n", "<Leader>wj", "<C-W>J", { desc = "Move down"  })
map("n", "<Leader>wk", "<C-W>K", { desc = "Move up"    })
map("n", "<Leader>wh", "<C-W>H", { desc = "Move left"  })
map("n", "<Leader>wl", "<C-W>L", { desc = "Move right" })
-- kinda pointless
map("n", "<Leader>wn", "<C-W>w", { desc = "Next" })
map("n", "<Leader>wN", "<C-W>W", { desc = "Prev" })
map("n", "<Leader>wp", "<C-W>p", { desc = "Last accessed" })
map("n", "<Leader>ww", "<C-W>n", { desc = "New window"   })
map("n", "<Leader>wc", "<C-W>c", { desc = "Close"        })
map("n", "<Leader>wo", "<C-W>o", { desc = "Close others" })
map("n", "<Leader>wx", "<C-W>x", { desc = "Exchange with next" })
map("n", "<Leader>we", "<C-W>=", { desc = "Equal dimensions" })
map("n", "<Leader>wr", "<C-W>r", { desc = "Rotate downwards" })
map("n", "<Leader>wR", "<C-W>R", { desc = "Rotate upwards"   })
map("n", "<Leader>ws", "<C-W>v", { desc = "Split vertical"   })
map("n", "<Leader>wS", "<C-W>s", { desc = "Split horizontal" })


--      ADDITIONAL
map("n", "))", ")") -- )* taken by treesitter
map("n", "((", "(") -- TODO: can't keep ( and )
map("n", "<C-I>", "<C-I>") -- jump list
map({ "n", "i" }, "<Esc>", "<Esc><Cmd>noh<CR>")
-- visual stuff
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "<S-Down>", ":move '>+1<CR>gv=gv")
map("v", "<S-UP>",   ":move '<-2<CR>gv=gv")
-- lock the cursor at the buffer center
map("n", "J", "mjJ`j")
map("n", "n", "nzvzz")
map("n", "N", "Nzvzz")
map("n", "*", "*zvzz")
map("n", "#", "#zvzz")
map("n", "g*", "g*zvzz")
map("n", "g#", "g#zvzz")
map("n", "<C-D>", "<C-D>zz")
map("n", "<C-U>", "<C-U>zz")
-- down/up on wrapped lines
map("i", "<Down>", "<Cmd>norm! gj<CR>")
map("i", "<Up>",   "<Cmd>norm! gk<CR>")
map({ "n", "x" }, "<Down>", "j", { remap = true })
map({ "n", "x" }, "<Up>",   "k", { remap = true })
map({ "n", "x" }, "j", [[v:count == 0 ? "gj" : "j"]], { expr = true })
map({ "n", "x" }, "k", [[v:count == 0 ? "gk" : "k"]], { expr = true })


--      LAYOUT
map("n", "<A-Down>",  "<A-j>", { remap = true })
map("n", "<A-Up>",    "<A-k>", { remap = true })
map("n", "<A-Left>",  "<A-h>", { remap = true })
map("n", "<A-Right>", "<A-l>", { remap = true })
map("n", "<C-Down>",  "<C-j>", { remap = true })
map("n", "<C-Up>",    "<C-k>", { remap = true })
map("n", "<C-Left>",  "<C-h>", { remap = true })
map("n", "<C-Right>", "<C-l>", { remap = true })
map("n", "<A-j>", "<C-W>j", { desc = "Lower window" })
map("n", "<A-k>", "<C-W>k", { desc = "Upper window" })
map("n", "<A-h>", "<C-W>h", { desc = "Left  window" })
map("n", "<A-l>", "<C-W>l", { desc = "Right window" })
map("n", "<C-j>", "<Cmd>resize -2<CR>", { desc = "Decrease height" })
map("n", "<C-k>", "<Cmd>resize +2<CR>", { desc = "Increase height" })
map("n", "<C-h>", "<Cmd>vert resize -2<CR>", { desc = "Decrease width" })
map("n", "<C-l>", "<Cmd>vert resize +2<CR>", { desc = "Increase width" })
