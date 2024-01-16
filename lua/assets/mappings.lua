local map = vim.keymap.set

--      LEADER
local w = require("assets.utils").with
local Lmap = require("assets.utils").Lmap

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
Lmap("p", "Clipboard paste",      [["+p]])
Lmap("p", "x", "Void paste",      [["_dP]])
Lmap("d", "nx", "Void delete",    [["_d]])
Lmap("y", "nx", "Clipboard yank", [["+y]])
Lmap("Y", "nx", "Clipboard Yank", [["+Y]])

-- Quickfix list
Lmap("co", "Open",        "<Cmd>ccopen<CR>")
Lmap("cc", "Close",       "<Cmd>cclose<CR>")
Lmap("cn", "Next item",   "<Cmd>cnext<CR>")
Lmap("ce", "Prev item",   "<Cmd>cprev<CR>")
Lmap("cN", "Newer list",  "<Cmd>cnewer<CR>")
Lmap("cE", "Older list",  "<Cmd>colder<CR>")
Lmap("cl", "Last item",   "<Cmd>clast<CR>")
Lmap("cf", "First item",  "<Cmd>cfirst<CR>")
-- Location list
Lmap("Co", "Open",        "<Cmd>lcopen<CR>")
Lmap("Cc", "Close",       "<Cmd>lclose<CR>")
Lmap("Cn", "Next item",   "<Cmd>lnext<CR>")
Lmap("Ce", "Prev item",   "<Cmd>lprev<CR>")
Lmap("CN", "Newer list",  "<Cmd>lnewer<CR>")
Lmap("CE", "Older list",  "<Cmd>lolder<CR>")
Lmap("Cl", "Last item",   "<Cmd>llast<CR>")
Lmap("Cf", "First item",  "<Cmd>lfirst<CR>")

-- Buffers
Lmap("bn", "Next",               "<Cmd>bnext<CR>")
Lmap("bN", "Prev",               "<Cmd>bprev<CR>")
Lmap("bd", "Delete",             "<Cmd>bdelete<CR>")
Lmap("bu", "Unload",             "<Cmd>bunload<CR>")
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
local lsp = vim.lsp.buf
local diag = vim.diagnostic
-- Normal
Lmap("lh", "Help",                lsp.hover)
Lmap("ls", "Signature help",      lsp.signature_help)
Lmap("lo", "Diagnostics float",   diag.open_float)
Lmap("ln", "Rename",              lsp.rename)
Lmap("lv", "Highlight",           lsp.document_highlight)
Lmap("lV", "Clear highlight",     lsp.clear_references)
Lmap("ld", "Definition",          lsp.definition)
Lmap("lD", "Declaration",         lsp.declaration)
Lmap("lt", "Type definition",     lsp.type_definition)
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
-- List
Lmap("lld", "Diagnostics Q",     diag.setqflist)
Lmap("llD", "Diagnostics L",     diag.setloclist)
Lmap("llr", "References",        lsp.references)
Lmap("llb", "Buffer symbols",    lsp.document_symbol)
Lmap("llw", "Workspace symbols", lsp.workspace_symbol)
Lmap("lli", "Incoming calls",    lsp.incoming_calls)
Lmap("llo", "Outgoing calls",    lsp.outgoing_calls)
Lmap("llm", "Implementations",   lsp.implementation)
-- Workspace
Lmap("lwa", "Add folder",    lsp.add_workspace_folder)
Lmap("lwr", "Remove folder", lsp.remove_workspace_folder)
Lmap("lwl", "List folders",  function() vim.print(lsp.list_workspace_folders()) end)


-- Next/Prev
if not package.loaded["nvim-treesitter.textobjects.repeatable_move"] then
    local function make_pair(char, desc, next, prev)
        map("n", "]"..char, next, { desc = "Next "..desc })
        map("n", "["..char, prev, { desc = "Prev "..desc })
    end

    make_pair("q", "quickfix", "<Cmd>cnext<CR>", "<Cmd>cprev<CR>")
    make_pair("Q", "loclist",  "<Cmd>lnext<CR>", "<Cmd>lprev<CR>")
    make_pair("b", "buffer",   "<Cmd>bnext<CR>", "<Cmd>bprev<CR>")
    make_pair("w", "window",   "<Cmd>wnext<CR>", "<Cmd>wprev<CR>")
    make_pair("d", "diagnostic", diag.goto_next, diag.goto_prev)
end



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
