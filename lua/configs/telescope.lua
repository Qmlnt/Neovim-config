local telescope = require "telescope"
local builtin = require "telescope.builtin"
local layout = require "telescope.actions.layout"
--local actions = require "telescope.actions"

telescope.setup {
    defaults = {
        layout_strategy = "flex",
        --preview = { hide_on_startup = true, filesize_limit = 0.1 --MB },
        layout_config = {
            vertical = { width = 0.9, height = 0.9 },
            horizontal = { width = 0.9, height = 0.7 },
        },
        cycle_layout_list = { "vertical", "horizontal" },
        -- borderchars = { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼" },
        path_display = { shorten = { len = 1, exclude = { -1 } } },
        vimgrep_arguments = { -- live_grep & grep_string
            "rg", "--color=never", "--no-heading", "--with-filename",
            "--line-number", "--column", "--smart-case", "--trim" -- trim spaces
        },
        mappings = {
            i = {
                ["<Esc>"] = "close",
                ["<C-d>"] = "delete_buffer", -- for buffers
                ["<C-h>"] = "select_horizontal", -- H| split
                ["<C-p>"] = layout.toggle_preview,
                ["<C-r>"] = layout.cycle_layout_next,
                ["<C-s>"] = "cycle_previewers_next", -- for git commits
                ["<C-a>"] = "cycle_previewers_prev",
                ["<C-n>"] = "preview_scrolling_down",
                ["<C-e>"] = "preview_scrolling_up",
                ["<C-Down>"] = "cycle_history_next",
                ["<C-Up>"] = "cycle_history_prev",
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
    which_key.add({
        { "<Leader>s", group = "Search" },
        { "<Leader>sh", group = "Git" },
        { "<Leader>sl", group = "LSP" },
    })
end


Lmap("f", Try(builtin.git_files, builtin.find_files))
Lmap(".", function() builtin.find_files { cwd = vim.fn.expand("%:p:h") } end)
Lmap("/", builtin.current_buffer_fuzzy_find)

Lmap("so", builtin.oldfiles)
Lmap("sb", "Buffers",        builtin.buffers)
Lmap("sf", "Files workdir",  builtin.find_files)
Lmap("sn", "Nvim dotfiles",  W(builtin.find_files) { cwd = vim.fn.expand("~/.config/nvim") })
Lmap("s.", "Dotfiles",       W(builtin.find_files) { cwd = vim.fn.expand("~/.config/") })
Lmap("sd", "Diagnostics",    builtin.diagnostics)
Lmap("ss", "Str in workdir", builtin.live_grep)
Lmap("sk", "Help tags",      builtin.help_tags)
Lmap("sm", "Man pages",      builtin.man_pages)
Lmap("s/", "/ history",      builtin.search_history)
Lmap("sq", "Quickfix hist",  builtin.quickfixhistory)
Lmap("sc", "nx", "Cursor workdir", builtin.grep_string)
Lmap("sp", "Pickers",        builtin.pickers)
Lmap("sr", "Resume",         builtin.resume)
Lmap("st", "Treesitter obj", builtin.treesitter)
-- Git
Lmap("shf", "Files",       builtin.git_files)
Lmap("shs", "Status",      builtin.git_status)
Lmap("shc", "Commits",     builtin.git_commits)
Lmap("shB", "Branches",    builtin.git_branches)
Lmap("shb", "Buf commits", builtin.git_bcommits)
-- LSP
Lmap("sld", "Definitions",       builtin.lsp_definitions)
Lmap("slt", "Type defenitions",  builtin.lsp_type_definitions)
Lmap("slr", "References",        builtin.lsp_references)
Lmap("sli", "Incoming calls",    builtin.lsp_incoming_calls)
Lmap("slo", "Outgoing calls",    builtin.lsp_outgoing_calls)
Lmap("slm", "Implementations",   builtin.lsp_implementations)
Lmap("sls", "Buffer symbols",    builtin.lsp_document_symbols)
Lmap("slW", "Workspace symbols", builtin.lsp_workspace_symbols)
Lmap("slw", "Workspace dynamic", builtin.lsp_dynamic_workspace_symbols)
-- TODO Lmap("shb", "x", "Buf commits", builtin.git_bcommits_range)
