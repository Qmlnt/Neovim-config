vim.g.mapleader = " " -- must be before any plugins
vim.g.maplocalleader = " "
local map = vim.keymap.set

-- programs?
map("n", "<Leader>nw", vim.cmd.Ex)
map("n", "<Leader>l", "<CMD>Lazy<CR>")

-- handy
map("n", "<C-i>", "<C-i>") -- jump list
map({ "n", "i" }, "<Esc>", "<CMD>noh<CR><Esc>")

-- clipboard stuff
map("x", "<Leader>p", [["_dP]])
map("n", "<Leader>p", [["+p]])
map({ "n", "v" }, "<Leader>d", [["_d]])
map({ "n", "v" }, "<Leader>y", [["+y]])
map({ "n", "v" }, "<Leader>Y", [["+Y]])

-- lock the cursor at the buffer center
map("n", "J", "mjJ`j")
map("n", "n", "nzvzz")
map("n", "N", "Nzvzz")
map("n", "*", "*zvzz")
map("n", "#", "#zvzz")
map("n", "g*", "g*zvzz")
map("n", "g#", "g#zvzz")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- visual stuff
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "<S-Down>", ":move '>+1<CR>gv=gv")
map("v", "<S-UP>",   ":move '<-2<CR>gv=gv")

-- down/up on wrapped lines
map({ "n", "x" }, "<Down>", "j", { remap = true })
map({ "n", "x" }, "<Up>",   "k", { remap = true })
map({ "n", "x" }, "j", [[v:count == 0 ? "gj" : "j"]], { expr = true })
map({ "n", "x" }, "k", [[v:count == 0 ? "gk" : "k"]], { expr = true })


--      LAYOUT
--map("n", "]b", "<CMD>bnext<CR>",        { desc = "Next buffer" }) -- NOTE: taken by treesitter
--map("n", "[b", "<CMD>bprevious<CR>",    { desc = "Prev buffer" })
map("n", "<Leader>b", "<CMD>bnext<CR>", { desc = "Next buffer" })
-- windows
map("n", "<C-Down>",  "<C-j>", { remap = true })
map("n", "<C-Up>",    "<C-k>", { remap = true })
map("n", "<C-Left>",  "<C-h>", { remap = true })
map("n", "<C-Right>", "<C-l>", { remap = true })
map("n", "<A-Down>",  "<A-j>", { remap = true })
map("n", "<A-Up>",    "<A-k>", { remap = true })
map("n", "<A-Left>",  "<A-h>", { remap = true })
map("n", "<A-Right>", "<A-l>", { remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Upper window" })
map("n", "<C-h>", "<C-w>h", { desc = "Left window"  })
map("n", "<C-l>", "<C-w>l", { desc = "Right window" })
map("n", "<A-j>", "<CMD>resize -2<CR>", { desc = "Decrease height" })
map("n", "<A-k>", "<CMD>resize +2<CR>", { desc = "Increase height" })
map("n", "<A-h>", "<CMD>vertical resize -2<CR>", { desc = "Decrease width" })
map("n", "<A-l>", "<CMD>vertical resize +2<CR>", { desc = "Increase width" })


-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>-",  "<C-W>s", { desc = "Split window below" })
map("n", "<leader>|",  "<C-W>v", { desc = "Split window right" })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
