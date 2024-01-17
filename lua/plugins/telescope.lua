return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    event = "User VeryLazyFile",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require "telescope".setup {
            defaults = { mappings = {
                i = {
                    ["<C-h>"] = "which_key",
                    --["<C-n>"] = "scrolldocs",
                    --["<C-e>"] = "scrolldocs",
                },
                n = { ["<C-h>"] = "which_key" }
            } }
        }
        local builtin = require("telescope.builtin")
        -- File
        Lmap("sw", "Files WD",       builtin.find_files)
        Lmap("sg", "Git Files",      builtin.git_files)
        Lmap("ss", "String WD",      builtin.live_grep)
        Lmap("sc", "nx", "Cursor str WD", builtin.grep_string)
        -- Vim
        Lmap("sf", "Fuzzy find buf", builtin.current_buffer_fuzzy_find)
        Lmap("sk", "Help tags", builtin.help_tags)
        Lmap("sK", "Man pages", builtin.man_pages)

        -- TODO Do I even need these?
        Lmap("sb", "Buffers",   builtin.buffers)
        Lmap("so", "Oldfiles",  builtin.oldfiles)
        Lmap("s:", ": history", builtin.command_history)
        Lmap("s/", "/ history", builtin.search_history)
        Lmap("sm", "Marks",     builtin.marks)
        Lmap("sq", "Quickfix",  builtin.quickfix) -- quickfixhistory?
        Lmap("sQ", "Loclist",   builtin.loclist)
    end
}
