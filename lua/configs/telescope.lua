local telescope = require "telescope"
local builtin = require "telescope.builtin"
local layout = require "telescope.actions.layout"

telescope.setup {
    defaults = {
        layout_strategy = "vertical",
        preview = { hide_on_startup = true },
        mappings = {
            i = {
                ["<C-p>"] = layout.toggle_preview,
                ["<C-r>"] = layout.cycle_layout_next,
                ["<C-h>"] = "select_horizontal",
                ["<C-n>"] = "preview_scrolling_up",
                ["<C-e>"] = "preview_scrolling_down",
                ["<C-Down>"] = "cycle_history_prev",
                ["<C-Up>"] = "cycle_history_next",
            },
        }
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    }
}

telescope.load_extension("fzf")

local which_key = package.loaded["which-key"]
if which_key then
    which_key.register({
        s = { name = "Search" },
        sh = { name = "Git" }
    }, { prefix = "<Leader>" })
end


Lmap("sw", "Workdir files",  builtin.find_files)
Lmap("sb", "Buffers",        builtin.buffers)
Lmap("sf", "Fuzzy buffer",   builtin.current_buffer_fuzzy_find)
Lmap("ss", "String workdir", builtin.live_grep)
Lmap("sc", "nx", "Cursor workdir", builtin.grep_string)
Lmap("sk", "Help tags",      builtin.help_tags)
Lmap("sK", "Man pages",      builtin.man_pages)
Lmap("so", "Oldfiles",       builtin.oldfiles)
Lmap("sp", "Pickers",        builtin.pickers)
Lmap("sq", "Quickfix hist",  builtin.quickfixhistory)
Lmap("st", "Treesitter obj", builtin.quickfixhistory)
Lmap("s/", "/ history",      builtin.search_history)
-- TODO LSP
Lmap("shf", "Files",       builtin.git_files)
Lmap("shs", "Status",      builtin.git_status)
Lmap("shc", "Commits",     builtin.git_commits)
Lmap("shb", "Buf commits", builtin.git_bcommits)
-- TODO Lmap("sgb", "x", "Buf commits", builtin.git_bcommits_range)

