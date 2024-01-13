local map = vim.keymap.set
local diag = vim.diagnostic
local lsp = vim.lsp.buf
local w = require("assets.utils").with
local Lmap = require("assets.utils").Lmap


-- TODO quickfix mappings
--      LEADER
Lmap("r", "<C-R>")

-- Utilities
Lmap("ul", "<Cmd>Lazy<CR>")
Lmap("um", "<Cmd>Mason<CR>")
Lmap("uL", "<Cmd>LspInfo<CR>")
Lmap("uc", "<Cmd>CmpStatus<CR>")
Lmap("un", "Netrw", vim.cmd.Ex)

-- Toggle stuff
Lmap("tn", "Number", "<Cmd>set number!<CR>")
Lmap("tw", "Wrap",   "<Cmd>set wrap!<CR><Cmd>set wrap?<CR>")
Lmap("tc", "Column", function() vim.o.colorcolumn = vim.o.colorcolumn == "" and "80,100" or "" end)

-- Clipboard stuff
Lmap("p", "Clipboard paste", [["+p]])
Lmap("p", "x", "Void paste", [["_dP]])
Lmap("d", "nx", "Void delete",   [["_d]])
Lmap("y", "nx", "Clipboard yank", [["+y]])
Lmap("Y", "nx", "Clipboard Yank", [["+Y]])

-- Buffers
Lmap("bn", "Next",   "<Cmd>bnext<CR>")
Lmap("bN", "Prev",   "<Cmd>bprev<CR>")
Lmap("bd", "Delete", "<Cmd>bdelete<CR>")
Lmap("bu", "Unload", "<Cmd>bunload<CR>")
Lmap("bp", "Last accessed",      "<Cmd>buffer#<CR>")
Lmap("bm", "Last modified",      "<Cmd>bmodified<CR>")
Lmap("bh", "H- split with next", "<Cmd>sbnext<CR>")
Lmap("bH", "H- split with prev", "<Cmd>sbprev<CR>")
Lmap("bv", "V| split with next", "<Cmd>vert sbnext<CR>")
Lmap("bV", "V| split with prev", "<Cmd>vert sbprev<CR>")
Lmap("bs", "V| split with last", "<Cmd>vert sbuffer#<CR>")
Lmap("bS", "H- split with last", "<Cmd>sbuffer#<CR>")

-- Windows 
Lmap("w<Down>", "Move win down",  "<C-W>J")
Lmap("w<Up>",   "Move win up",    "<C-W>K")
Lmap("w<Left>", "Move win left",  "<C-W>H")
Lmap("w<Right>","Move win right", "<C-W>L")
Lmap("wj", "Move win down",       "<C-W>J")
Lmap("wk", "Move win up",         "<C-W>K")
Lmap("wh", "Move win left",       "<C-W>H")
Lmap("wl", "Move win right",      "<C-W>L")
Lmap("ww", "New",                 "<C-W>n")
Lmap("wn", "Next",                "<C-W>w")
Lmap("wN", "Prev",                "<C-W>W")
Lmap("wp", "Last accessed",       "<C-W>p")
Lmap("wc", "Close",               "<C-W>c")
Lmap("wo", "Close others",        "<C-W>o")
Lmap("wx", "Xchange with next",   "<C-W>x")
Lmap("we", "Equal size",          "<C-W>=")
Lmap("wW", "Max width",           "<C-W>|")
Lmap("wH", "Max height",          "<C-W>_")
Lmap("wr", "Rotate downwards",    "<C-W>r")
Lmap("wR", "Rotate upwards",      "<C-W>R")
Lmap("ws", "V| split",            "<C-W>v")
Lmap("wS", "H- split",            "<C-W>s")
Lmap("wC", "Close last accessd",  "<C-W>p<C-W>c")

-- LSP
-- Normal
Lmap("lh", "Help",                lsp.hover)
Lmap("ls", "Signature help",      lsp.signature_help)
Lmap("lo", "Diagnostics float",   diag.open_float)
Lmap("ln", "Rename",              lsp.rename)
Lmap("lv", "Highlight",           lsp.document_highlight)
Lmap("lV", "Clear highlight",     lsp.clear_references)
Lmap("la", "nx", "Code action",   lsp.code_action)
Lmap("lf", "nx", "Format",      w(lsp.format) { async = true })
Lmap("lt", "Type under cursor", function() vim.lsp.util.open_floating_preview(
    { vim.lsp.semantic_tokens.get_at_pos()[1].type },
    nil, { border = require("assets.assets").border_bleed })
end)
-- Control
Lmap("lcs", "Show",    diag.show)
Lmap("lch", "Hide",    diag.hide)
Lmap("lce", "Enable",  diag.enable)
Lmap("lcd", "Disable", diag.disable)
-- Go to
Lmap("lgd", "Definition",      lsp.definition)
Lmap("lgD", "Declaration",     lsp.declaration)
Lmap("lgt", "Type definition", lsp.type_definition)
Lmap("lgi", "Implementation",  lsp.implementation)
-- List
Lmap("lld", "Diagnostics",          diag.setqflist)
Lmap("llr", "References",           lsp.references)
Lmap("llw", "Workspace references", lsp.workspace_symbol)
Lmap("lls", "Symbols",              lsp.document_symbol)
Lmap("lli", "Incoming calls",       lsp.incoming_calls)
Lmap("llo", "Outgoing calls",       lsp.outgoing_calls)
--Lmap("llD", "Diagnostics list",   diag.setloclist)
-- Workspace
Lmap("lwa", "Add folder",    lsp.add_workspace_folder)
Lmap("lwr", "Remove folder", lsp.remove_workspace_folder)
Lmap("lwl", "List folders",  function() vim.print(lsp.list_workspace_folders()) end)
-- Other
map("n", "]d", diag.goto_next, { desc = "Next diagnostic" })
map("n", "[d", diag.goto_prev, { desc = "Prev diagnostic" })



--      ADDITIONAL
map("n", "<C-I>", "<C-I>") -- jump list
map("", "<Esc>", "<Esc><Cmd>noh<CR>")
map("n", "))", ")", { desc = "Sentence forward"  }) -- )* taken by treesitter
map("n", "((", "(", { desc = "Sentence backward" })
-- visual stuff
map("x", "<", "<gv")
map("x", ">", ">gv")
map("x", "<S-Down>", ":move '>+1<CR>gv=gv")
map("x", "<S-UP>",   ":move '<-2<CR>gv=gv")
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
