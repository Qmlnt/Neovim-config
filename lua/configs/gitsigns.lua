local gs = require "gitsigns"

gs.setup {
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
    preview_config = { border = vim.g.border_bleed },
}

-- Normal
Lmap("hb", "Blame line",        gs.blame_line)
Lmap("hB", "Blame full",      W(gs.blame_line) { full = true })
Lmap("hs", "Stage hunk",        gs.stage_hunk)
Lmap("hr", "Reset hunk",        gs.reset_hunk)
Lmap("hS", "Stage buffer",      gs.stage_buffer)
Lmap("hR", "Reset buffer",      gs.reset_buffer)
Lmap("hu", "Undo stage hunk",   gs.undo_stage_hunk) -- only in current session
Lmap("hp", "Preview hunk",      gs.preview_hunk)
Lmap("hi", "Inline preview",    gs.preview_hunk_inline)
Lmap("hl", "List hunks",        gs.setloclist)
Lmap("hq", "Qlist all hunks", W(gs.setqflist) "attached")
Lmap("hQ", "Qlist ALL hunks", W(gs.setqflist) "all")
Lmap("hs", "x", "Stage region", function() gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" } end)
Lmap("hr", "x", "Reset region", function() gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" } end)
-- Toggle
Lmap("hts", "Signs",     gs.toggle_signs)
Lmap("htn", "Number hl", gs.toggle_numhl)
Lmap("htl", "Line hl",   gs.toggle_linehl)
Lmap("htd", "Deleted",   gs.toggle_deleted)
Lmap("htw", "Word diff", gs.toggle_word_diff)
Lmap("htb", "Blame",     gs.toggle_current_line_blame)
-- View file
Lmap("hvh", "HEAD",        W(gs.show) "@")
Lmap("hvp", "HEAD~",       W(gs.show) "~")
Lmap("hvs", "Staged",        gs.show)
Lmap("hvH", "Diff HEAD",   W(gs.diffthis, "@", { split = "belowright" }))
Lmap("hvP", "Diff HEAD~",  W(gs.diffthis, "~", { split = "belowright" }))
Lmap("hvS", "Diff Staged", W(gs.diffthis, nil, { split = "belowright" }))
-- Control
Lmap("hca", "Attach",             gs.attach)
Lmap("hcd", "Detach",             gs.detach)
Lmap("hcD", "Detach all",         gs.detach_all)
Lmap("hcr", "Refresh",            gs.refresh)
Lmap("hcs", "Base->staged",       gs.change_base)
Lmap("hcS", "Base->staged all", W(gs.change_base, nil, true))
Lmap("hch", "Base->HEAD",       W(gs.change_base) "@")
Lmap("hcH", "Base->HEAD all",   W(gs.change_base, "@", true))
-- Other
vim.keymap.set({"x", "o"}, "ih", gs.select_hunk, { desc = "Select hunk" })
MakePair("h", "hunk", gs.next_hunk, gs.prev_hunk)
