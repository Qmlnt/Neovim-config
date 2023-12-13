local o = vim.opt

-- behaviour
o.swapfile = false
o.undofile = true
o.undolevels = 10000
o.updatetime = 1000 -- Save swap, trigger CursorHold
o.timeoutlen = 400 -- ms to wait for a mapped sequence
o.splitbelow = true
o.splitright = true
o.ignorecase = true
o.smartcase = true -- don't ignore case for CAPITALS
o.hlsearch  = true -- default
o.incsearch = true -- default
o.confirm = true -- :q when there are changes
o.mouse = "a"
o.clipboard = "unnamedplus" -- TODO
o.formatoptions:append "n" -- numbered lists
-- movement
o.scrolloff = 7
o.sidescrolloff = 10
o.autoindent = true -- default
o.smartindent = true
o.expandtab = true -- spaces > tabs
o.tabstop = 8 -- to see the Tabs
o.softtabstop = 4
o.shiftwidth = 4 -- >> and <<
-- look
o.title = true -- better window title
o.wrap = false
o.list = true -- show trailing invisible chars
o.number = true
o.relativenumber = true
o.numberwidth = 1 -- automatic width ^.^
o.cursorline = true
o.colorcolumn = "80"
o.conceallevel = 3 -- hide markup
o.termguicolors = true -- RGB true colors
-- o.showmode = false -- there is statusline for this
-- o.cursorlineopt = number,screenline -- can't determine for now
--o.laststatus = 3 -- TODO
--vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time

--vim.opt.shortmess:append "c"

--o.whichwrap:append "<,>,[,]"
--o.iskeyword:append "-"
--vim.g.netrw_banner = 0 -- TODO
--vim.g.netrw_mouse = 2 -- TODO
