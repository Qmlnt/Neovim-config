local o = vim.opt

-- behaviour
o.undofile = true
o.swapfile = false
o.mouse = 'a'
o.clipboard = 'unnamedplus' -- TODO
o.hlsearch = true  -- default
o.incsearch = true -- default
o.splitbelow = true
-- movement
o.scrolloff = 7
o.sidescrolloff = 5
o.autoindent = true -- default
o.smartindent = true
o.expandtab = true
o.tabstop = 8 -- to see the Tabs
o.softtabstop = 4
o.shiftwidth = 4 -- >> and <<
-- look
o.title = true
o.wrap = false
o.number = true
o.numberwidth = 1 -- automatic ^.^
o.relativenumber = true
o.colorcolumn = "80"
o.cursorline = true
o.termguicolors = true
-- o.cursorlineopt = number,screenline -- can't determine for now

--o.updatetime = 100 -- TODO
--o.laststatus = 3 -- TODO
--vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
--vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications

--vim.opt.shortmess:append "c"

--o.whichwrap:append "<,>,[,]"
--o.iskeyword:append "-"
--vim.g.netrw_banner = 0 -- TODO
--vim.g.netrw_mouse = 2 -- TODO
