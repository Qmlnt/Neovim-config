local M = {
    "lewis6991/gitsigns.nvim",
    event = "User HalfLazy",
    enabled = true
}


local gitsigns_config = {
    auto_attach = true,
    attach_to_untracked = false, -- use keymap
    max_file_length = 10000,
    update_debounce = 500,
    -- base = "@", -- index by default
    -- worktrees = {}, -- TODO for dotfiles
    numhl = true,
    signcolumn = false,
    current_line_blame = false,
    sign_priority = 6,

    diff_opts = {
        internal = true, -- for linematch
        linematch = true, -- align lines
        algorithm = "histogram", -- myers, minimal, patience, histrogram
    },
    preview_config = { border = require("assets.assets").border_bleed },
}


local function setup_mappings()
    local gs = package.loaded.gitsigns

    local map = vim.keymap.set
    local w = require("assets.utils").with
    local Lmap = require("assets.utils").Lmap
    --[[ local function Lmap(keys, desc, func, mode) -- wasn't a fan of these, but damn
        map(mode or "n", "<Leader>"..keys, func, { desc = desc })
    end ]]

    Lmap("hga", "Attach",               gs.attach)
    Lmap("hgd", "Detach",               gs.detach)
    Lmap("hgD", "Detach all",           gs.detach_all)
    Lmap("hgr", "Refresh",              gs.refresh)

    Lmap("hts", "Signs",                gs.toggle_signs)
    Lmap("htn", "Number hl",            gs.toggle_numhl)
    Lmap("htl", "Line hl",              gs.toggle_linehl)
    Lmap("htd", "Deleted",              gs.toggle_deleted)
    Lmap("htw", "Word diff",            gs.toggle_word_diff)
    Lmap("htb", "Blame",                gs.toggle_current_line_blame)

    Lmap("hl",  "Location list",        gs.setloclist)
    Lmap("hQ",  "Quickfix all",       w(gs.setqflist) "all")
    Lmap("hq",  "Quickfix attched",   w(gs.setqflist) "attached")
    -- View file
    Lmap("hs",  "Staged version",       gs.show)
    Lmap("hc",  "Commited version",   w(gs.show) "@")
    Lmap("hc",  "Previous version",   w(gs.show) "~")
    -- Diff
    Lmap("hdd", "With indexed",       w(gs.diffthis, nil, { split = "belowright" }))
    Lmap("hdD", "With HEAD",          w(gs.diffthis, "@", { split = "belowright" }))
    Lmap("hdp", "With previous",      w(gs.diffthis, "~", { split = "belowright" }))
    Lmap("hds", "Base to stage",        gs.change_base)
    Lmap("hdS", "To staged globally", w(gs.change_base, nil, true))
    Lmap("hdh", "Base to HEAD",       w(gs.change_base) "@")
    Lmap("hdH", "To HEAD globally",   w(gs.change_base, "@", true))

    Lmap("hb",  "Blame line",           gs.blame_line)
    Lmap("hB",  "Blame line",         w(gs.blame_line) { full = true })
    Lmap("hi",  "Preview inline",       gs.preview_hunk_inline)
    Lmap("hp",  "Preview hunk",         gs.preview_hunk)
    Lmap("hs",  "Stage hunk",           gs.stage_hunk)
    Lmap("hr",  "Reset hunk",           gs.reset_hunk)
    Lmap("hS",  "Stage buffer",         gs.stage_buffer)
    Lmap("hR",  "Reset buffer",         gs.reset_buffer)
    Lmap("hu",  "Undo stage hunk",      gs.undo_stage_hunk) -- only for current session

    Lmap("hs",  "Stage hunk", function() gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" } end, "x")
    Lmap("hr",  "Reset hunk", function() gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" } end, "x")

    map("n", "[h", gs.prev_hunk, { desc = "Previous hunk" })
    map("n", "]h", gs.next_hunk, { desc = "Next hunk" })
    map({"x", "o"}, "ih", gs.select_hunk, { desc = "Select hunk" })
end


function M.config()
    require("gitsigns").setup(gitsigns_config)
    setup_mappings()
end

return M
