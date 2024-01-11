local M = {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    enabled = false
}


local gitsigns_config = {
    signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
        untracked    = { text = "┆" },
    },
    signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
    numhl      = true,  -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        follow_files = true
    },
    auto_attach = true,
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- "eol" | "overlay" | "right_align"
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100, --TODO lag?
    status_formatter = nil, -- Use default
    max_file_length = 10000, -- Disable if file is longer than this (in lines)
    preview_config = {
        -- Options passed to nvim_open_win
        border = require("assets.assets").border,
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1
    },
    yadm = {
        enable = false
    },
}


local function setup_mappings(gitsigns)
    local map = vim.keymap.set
    --local w = require("assets.utils").with

    map("n", "<Leader>hga", gitsigns.attach,     { desc = "Attach" })
    map("n", "<Leader>hgd", gitsigns.detach,     { desc = "Detach" })
    map("n", "<Leader>hgD", gitsigns.detach_all, { desc = "Detach all" })
    map("n", "<Leader>hgr", gitsigns.refresh,    { desc = "Refresh" })

    map("n", "<Leader>hs", gitsigns.show,  { desc = "Staged version" })
    map("n", "<Leader>hc", function() gitsigns.show "@" end,  { desc = "Commited version" })

    map("n", "<Leader>hl", gitsigns.setloclist, { desc = "Location list" })
    map("n", "<Leader>hQ", function() gitsigns.setqflist "all" end, { desc = "Quickfix all" })
    map("n", "<Leader>hq", function() gitsigns.setqflist "attached" end,  { desc = "Quickfix attched" })
    -- Diff
    map("n", "<Leader>hdd", function() gitsigns.diffthis(nil,  { split = "belowright" }) end, { desc = "With indexed" })
    map("n", "<Leader>hdD", function() gitsigns.diffthis("@", { split = "belowright" }) end, { desc = "With HEAD" })
    map("n", "<Leader>hds", function() gitsigns.change_base() end, { desc = "Base to stage" })
    map("n", "<Leader>hdh", function() gitsigns.change_base "@" end, { desc = "Base to HEAD" })

    map("n", "<Leader>hb", gitsigns.blame_line,  { desc = "Blame line" })
    map("n", "<Leader>hi", gitsigns.preview_hunk_inline,  { desc = "Preview inline" })
    map("n", "<Leader>hp", gitsigns.preview_hunk,  { desc = "Preview hunk" })

    map("n", "[h", gitsigns.prev_hunk,  { desc = "Previous hunk" })
    map("n", "]h", gitsigns.next_hunk,  { desc = "Next hunk" })

    map("n", "<Leader>hs", gitsigns.stage_buffer, { desc = "Stage buffer" })
    map("n", "<Leader>h?", gitsigns.stage_hunk, { desc = "Stage hunk" })
    map("v", "<leader>h?", function() gitsigns.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end, { desc = "Stage hunk" })
    map("n", "<Leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" }) -- only for current session

    map("n", "<Leader>htd", gitsigns.toggle_deleted, { desc = "Deleted" })
    map("n", "<Leader>htb", gitsigns.toggle_current_line_blame, { desc = "Blame" })
    map("n", "<Leader>htw", gitsigns.toggle_word_diff,  { desc = "Word diff" })
    map("n", "<Leader>htl", gitsigns.toggle_linehl,  { desc = "Line highlight" })
    map("n", "<Leader>htn", gitsigns.toggle_numhl,  { desc = "Number highlight" })
    map("n", "<Leader>hts", gitsigns.toggle_signs,  { desc = "Signs" })
    --map("n", "<Leader>h?", gitsigns.,  { desc = "" })


end


function M.config()
    --[[ gitsigns_config.on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
            if vim.wo.diff then return "]c" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
        end, {expr=true})

        map("n", "[c", function()
            if vim.wo.diff then return "[c" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
        end, {expr=true})

        -- Actions
        map("n", "<leader>hs", gs.stage_hunk)
        map("n", "<leader>hr", gs.reset_hunk)
        map("v", "<leader>hs", function() gs.stage_hunk {vim.fn.line("."), vim.fn.line("v")} end)
        map("v", "<leader>hr", function() gs.reset_hunk {vim.fn.line("."), vim.fn.line("v")} end)
        map("n", "<leader>hS", gs.stage_buffer)
        map("n", "<leader>hu", gs.undo_stage_hunk)
        map("n", "<leader>hR", gs.reset_buffer)
        map("n", "<leader>hp", gs.preview_hunk)
        map("n", "<leader>hb", function() gs.blame_line{full=true} end)
        map("n", "<leader>tb", gs.toggle_current_line_blame)
        map("n", "<leader>hd", gs.diffthis)
        map("n", "<leader>hD", function() gs.diffthis("~") end)
        map("n", "<leader>td", gs.toggle_deleted)

        -- Text object
        map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
    end ]]

    local gitsigns = require "gitsigns"
    gitsigns.setup(gitsigns_config)
    setup_mappings(gitsigns)
end

return M
