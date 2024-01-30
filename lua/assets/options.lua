local o = vim.opt

vim.g.mapleader = " " -- must be before any plugins
vim.g.maplocalleader = " "

-- behaviour
o.swapfile = false
o.undofile = true
o.undolevels = 10000
o.updatetime = 500 -- save swap, trigger CursorHold
o.timeout    = false -- hit <ESC> manually instead
o.timeoutlen = 600 -- ms to wait for a mapping sequence
o.splitbelow = true
o.splitright = true
o.ignorecase = true
o.smartcase  = true -- don't ignore case for CAPITALS
o.hlsearch  = true -- default
o.incsearch = true -- default
o.confirm = true -- :q when there are changes
o.iskeyword:append "-" -- is part of the word
o.shortmess = "atTIcCF" -- oO?
o.wildmode = "longest:full,full" -- cmd completion
o.completeopt = "menu,menuone,longest" -- omnifunc completion
o.mouse = "a"
--o.clipboard = "unnamed"plus?
o.formatoptions:append "n" -- indents for numbered lists
-- movement
o.scrolloff     = 7 -- vertical
o.sidescrolloff = 10
o.autoindent  = true -- default
o.smartindent = true
o.expandtab = true -- spaces > tabs
o.tabstop     = 8  -- to see the Tabs, see also `listchars`
o.softtabstop = 4
o.shiftwidth  = 4  -- >> and <<
o.virtualedit = "block" -- move cursor anywhere in visual block mode
-- look
o.cmdheight = 1  -- 0 is experimental
o.rulerformat = ""
o.pumheight = 10 -- lines in cmp menu
o.pumblend  = 10 -- cmp menu transparency
o.showmode = true -- in cmdline
o.wrap = false
o.linebreak = true -- when `wrap`, break lines at `breakat`
o.showbreak = "🞄" -- 🞄➣◜◞◟◝╴└╰... at the beginning of wrapped lines
o.breakindent = true -- for wrapped blocks to have indent
o.title = true -- better window title
o.list = true -- show trailing invisible chars
o.listchars = "tab:󰌒 ,trail:·,nbsp:%,leadmultispace:                ▏" -- ▎▍
o.colorcolumn = "80,100"
o.cursorline  = true
o.laststatus = 0 -- 3 for statusline only on last win; 0 to hide
o.conceallevel = 3 -- hide markup
o.number = true
o.numberwidth = 1 -- minimal possible width
o.relativenumber = true
o.signcolumn = "number"
o.termguicolors = true -- RGB True color
o.fillchars = {
    fold = " ",
    foldopen = "",
    foldclose = "",
    foldsep = " ",
    diff = "╱",
    eob = " ",
    lastline = "❭"
}
