local M = {
    "lewis6991/gitsigns.nvim",
    event = "User HalfLazy",
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


function M.config()
    local gs = require "gitsigns"
    gs.setup(gitsigns_config)

    local map = vim.keymap.set
    local w = require("assets.utils").with
    local Lmap = require("assets.utils").Lmap

    -- Normal
    Lmap("hb", "Blame line",         gs.blame_line)
    Lmap("hB", "Blame full",       w(gs.blame_line) { full = true })
    Lmap("hs", "Stage hunk",         gs.stage_hunk)
    Lmap("hr", "Reset hunk",         gs.reset_hunk)
    Lmap("hS", "Stage buffer",       gs.stage_buffer)
    Lmap("hR", "Reset buffer",       gs.reset_buffer)
    Lmap("hu", "Undo stage hunk",    gs.undo_stage_hunk) -- only for current session
    Lmap("hp", "Preview hunk",       gs.preview_hunk)
    Lmap("hi", "Inline preview",     gs.preview_hunk_inline)
    Lmap("hl", "List of hunks",      gs.setloclist)
    Lmap("hQ", "Qlist of all",     w(gs.setqflist) "all")
    Lmap("hq", "Qlist of attched", w(gs.setqflist) "attached")
    Lmap("hs", "x", "Stage hunks", function() gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" } end)
    Lmap("hr", "x", "Reset hunks", function() gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" } end)
    -- View file
    Lmap("hvs", "Staged",     gs.show)
    Lmap("hvh", "HEAD",     w(gs.show) "@")
    Lmap("hvp", "Previous", w(gs.show) "~")
    -- Diffthis
    Lmap("hds", "Staged",   w(gs.diffthis, nil, { split = "belowright" }))
    Lmap("hdh", "HEAD",     w(gs.diffthis, "@", { split = "belowright" }))
    Lmap("hdp", "Previous", w(gs.diffthis, "~", { split = "belowright" }))
    -- Toggle
    Lmap("hts", "Signs",     gs.toggle_signs)
    Lmap("htn", "Number hl", gs.toggle_numhl)
    Lmap("htl", "Line hl",   gs.toggle_linehl)
    Lmap("htd", "Deleted",   gs.toggle_deleted)
    Lmap("htw", "Word diff", gs.toggle_word_diff)
    Lmap("htb", "Blame",     gs.toggle_current_line_blame)
    -- Control
    Lmap("hca", "Attach",             gs.attach)
    Lmap("hcd", "Detach",             gs.detach)
    Lmap("hcD", "Detach from all",    gs.detach_all)
    Lmap("hcr", "Refresh",            gs.refresh)
    Lmap("hcs", "Base to staged",     gs.change_base)
    Lmap("hcS", "Base to staged G", w(gs.change_base, nil, true))
    Lmap("hch", "Base to HEAD",     w(gs.change_base) "@")
    Lmap("hcH", "Base to HEAD G",   w(gs.change_base, "@", true))
    -- Other
    map("n", "[h", gs.prev_hunk, { desc = "Previous hunk" })
    map("n", "]h", gs.next_hunk, { desc = "Next hunk" })
    map({"x", "o"}, "ih", gs.select_hunk, { desc = "Select hunk" })
end

return M
