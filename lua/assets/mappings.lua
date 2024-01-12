local map = vim.keymap.set
local diag = vim.diagnostic
local lsp = vim.lsp.buf


--      LEADER  TODO yoink Lmap from gitsigns?
map("n", "<Leader>r", "<C-R>")
-- Utilities
map("n", "<Leader>un", vim.cmd.Ex, { desc = "Netrw" })
map("n", "<Leader>ul", "<Cmd>Lazy<CR>")
map("n", "<Leader>um", "<Cmd>Mason<CR>")
map("n", "<Leader>uL", "<Cmd>LspInfo<CR>")
map("n", "<Leader>uc", "<Cmd>CmpStatus<CR>")
-- Toggle stuff
map("n", "<Leader>tn", "<Cmd>set number!<CR>", { desc = "Number" })
map("n", "<Leader>tw", "<Cmd>set wrap!<CR><Cmd>set wrap?<CR>", { desc = "Wrap" })
map("n", "<Leader>tc", function()
    vim.o.colorcolumn = vim.o.colorcolumn == "" and "80,100" or ""
end, { desc = "Column" })
-- Clipboard stuff
map("x", "<Leader>p", [["_dP]], { desc = "Void paste" })
map("n", "<Leader>p", [["+p]],  { desc = "Clipboard paste" })
map({ "n", "x" }, "<Leader>d", [["_d]], { desc = "Void delete" })
map({ "n", "x" }, "<Leader>y", [["+y]], { desc = "Clipboard yank" })
map({ "n", "x" }, "<Leader>Y", [["+Y]], { desc = "Clipboard Yank" })
-- Buffers
map("n", "<Leader>bn", "<Cmd>bnext<CR>", { desc = "Next" })
map("n", "<Leader>bN", "<Cmd>bprev<CR>", { desc = "Prev" })
map("n", "<Leader>bd", "<Cmd>bdelete<CR>", { desc = "Delete" })
map("n", "<Leader>bu", "<Cmd>bunload<CR>", { desc = "Unload" })
map("n", "<Leader>bp", "<Cmd>buffer#<CR>",   { desc = "Last accessed" })
map("n", "<Leader>bm", "<Cmd>bmodified<CR>", { desc = "Last modified" })
map("n", "<Leader>bh", "<Cmd>sbnext<CR>",        { desc = "H- split with next" })
map("n", "<Leader>bH", "<Cmd>sbprev<CR>",        { desc = "H- split with prev" })
map("n", "<Leader>bv", "<Cmd>vert sbnext<CR>",   { desc = "V| split with next" })
map("n", "<Leader>bV", "<Cmd>vert sbprev<CR>",   { desc = "V| split with prev" })
map("n", "<Leader>bs", "<Cmd>vert sbuffer#<CR>", { desc = "V| split with last" })
map("n", "<Leader>bS", "<Cmd>sbuffer#<CR>",      { desc = "H- split with last" })
-- Windows 
map("n", "<Leader>w<Down>",  "<C-W>J", { desc = "Move down"  })
map("n", "<Leader>w<Up>",    "<C-W>K", { desc = "Move up"    })
map("n", "<Leader>w<Left>",  "<C-W>H", { desc = "Move left"  })
map("n", "<Leader>w<Right>", "<C-W>L", { desc = "Move right" })
map("n", "<Leader>wj", "<C-W>J", { desc = "Move down"  })
map("n", "<Leader>wk", "<C-W>K", { desc = "Move up"    })
map("n", "<Leader>wh", "<C-W>H", { desc = "Move left"  })
map("n", "<Leader>wl", "<C-W>L", { desc = "Move right" })
map("n", "<Leader>ww", "<C-W>n", { desc = "New" })
map("n", "<Leader>wn", "<C-W>w", { desc = "Next" })
map("n", "<Leader>wN", "<C-W>W", { desc = "Prev" })
map("n", "<Leader>wp", "<C-W>p", { desc = "Last accessed" })
map("n", "<Leader>wc", "<C-W>c", { desc = "Close"        })
map("n", "<Leader>wo", "<C-W>o", { desc = "Close others" })
map("n", "<Leader>wx", "<C-W>x", { desc = "Exchange with next" })
map("n", "<Leader>we", "<C-W>=", { desc = "Equal size" })
map("n", "<Leader>wW", "<C-W>|", { desc = "Max width"  })
map("n", "<Leader>wH", "<C-W>_", { desc = "Max height" })
map("n", "<Leader>wr", "<C-W>r", { desc = "Rotate downwards" })
map("n", "<Leader>wR", "<C-W>R", { desc = "Rotate upwards"   })
map("n", "<Leader>ws", "<C-W>v", { desc = "V| split" })
map("n", "<Leader>wS", "<C-W>s", { desc = "H- split" })
map("n", "<Leader>wC", "<C-W>p<C-W>c", { desc = "Close last accessed" })

-- Diagnostics
map("n", "]d", diag.goto_next, { desc = "Next diagnostic" })
map("n", "[d", diag.goto_prev, { desc = "Prev diagnostic" })
map("n", "<Leader>lcs", diag.show,    { desc = "Show" })
map("n", "<Leader>lch", diag.hide,    { desc = "Hide" })
map("n", "<Leader>lce", diag.enable,  { desc = "Enable" })
map("n", "<Leader>lcd", diag.disable, { desc = "Disable" })
map("n", "<Leader>lo",  diag.open_float, { desc = "Floating diagnostics" })
map("n", "<Leader>ll",  diag.setloclist, { desc = "Location list (local)" })
map("n", "<Leader>lq",  diag.setqflist,  { desc = "Quickfix list (global)" })

-- LSP
map("n", "<Leader>lh", lsp.hover,               { desc = "Hover" })
map("n", "<Leader>ln", lsp.rename,              { desc = "Rename" })
map("n", "<Leader>ld", lsp.definition,          { desc = "Definition" })
map("n", "<Leader>lD", lsp.declaration,         { desc = "Declaration" })
map("n", "<Leader>lt", lsp.type_definition,     { desc = "Type definition" })
map("n", "<Leader>li", lsp.implementation,      { desc = "Implementation" })
map("n", "<Leader>lr", lsp.references,          { desc = "References" })
map("n", "<Leader>lv", lsp.document_highlight,  { desc = "Highlight references" })
map("n", "<Leader>lV", lsp.clear_references,    { desc = "Clear highlight" })
map("n", "<Leader>lQ", lsp.document_symbol,     { desc = "Quickfix of keywords" })
map("n", "<Leader>ls", lsp.signature_help,      { desc = "Signature help" })
map("n", "<Leader>lI", lsp.incoming_calls,      { desc = "Incoming calls" })
map("n", "<Leader>lO", lsp.outgoing_calls,      { desc = "Outgoing calls" })
map({ "n", "x" }, "<Leader>la", lsp.code_action, { desc = "Code action" })
map({ "n", "x" }, "<Leader>lf", function() lsp.format { async = true } end, { desc = "Format" })
map("n", "<Leader>lT", function() vim.lsp.util.open_floating_preview(
    { vim.lsp.semantic_tokens.get_at_pos()[1].type },
    nil, { border = require("assets.assets").border_bleed })
end, { desc = "Type under cursor" })
-- Workspace
map("n", "<Leader>lR", lsp.workspace_symbol, { desc = "Workspace references" })
map("n", "<Leader>lw", lsp.add_workspace_folder, { desc = "Add workspace" })
map("n", "<Leader>lW", lsp.remove_workspace_folder, { desc = "Remove workspace" })
map("n", "<Leader>lL", function() vim.print(lsp.list_workspace_folders())
end, { desc = "List folders" })



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
