local M = {
    "hrsh7th/nvim-cmp",
    --event = "VeryLazy",
    --event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",

        "L3MON4D3/LuaSnip", -- jsregexp is optional
        "saadparwaiz1/cmp_luasnip",

    }
}


local function exit_completion()
    vim.api.nvim_feedkeys("gi", "n", false)
end

local function trigger_or_next_completion()
    local cmp = require "cmp"
    if cmp.visible() then
        return cmp.select_next_item()
    end
    cmp.complete()

    -- Close the damn completion window
    local oneshot_keymap = require("assets").oneshot_keymap
    for _, key in ipairs { "<CR>", "<Tab>", "<Space>" } do
        oneshot_keymap("i", key, function()
            exit_completion()
            local keys = vim.api.nvim_replace_termcodes(key, true, false, true)
            vim.api.nvim_feedkeys(keys, "n", false)
        end, { buffer = 0 })
    end
end

local function longest_or_trigger_completion()
    local cmp = require "cmp"

    if cmp.visible() then
        return cmp.confirm { select = true,
            behavior = cmp.ConfirmBehavior.Replace }
    end

    cmp.complete { config = { -- should be fast asf
        sources = {
            { name = "nvim_lsp", group_iedex = 1 },
            { name = "buffer",   group_index = 2 } -- only current buf
        },
        performance = {
            throttle = 0,
            debounce = 15,
            max_view_entries = 10,
            fetching_timeout = 100
        },
    } }
    cmp.complete_common_string()
    --vim.schedule(function() exit_completion() end)
end

local function toggle_docs()
    local cmp = require "cmp"

    if not cmp.visible() then
        return
    end

    if cmp.visible_docs() then
        cmp.close_docs()
    else
        cmp.open_docs()
    end
end

local function get_completion_buffers()
    local buffers = {}
    for _, win_id in ipairs(vim.api.nvim_list_wins()) do
        local buff_id = vim.api.nvim_win_get_buf(win_id)
        local buff_lines = vim.api.nvim_buf_line_count(buff_id)
        local buff_bytes = vim.api.nvim_buf_get_offset(buff_id, buff_lines)

        if buff_bytes < 524288 then -- 512 KiB
            table.insert(buffers, buff_id)
        end
    end
    return buffers
end


function M.config()
    local cmp = require "cmp"

    cmp.setup.global { -- = cmp.setup
        preselect = cmp.PreselectMode.Item, -- Honour LSP preselect requests
        completion = {
            autocomplete = false,
            completeopt = "menu,menuone,longest" -- meh
        },
        view = { docs = { auto_open = false } },
        performance = {
            --debounce = 60,
            throttle = 15, -- 30
            --fetching_timeout = 500,
            max_view_entries = 40, -- 200
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end
        },
        mapping = { -- mapped for insert mode
            ["<S-Space>"] = trigger_or_next_completion,
            ["<C-Space>"] = cmp.select_prev_item,
            ["<S-CR>"] = longest_or_trigger_completion,         -- Replace
            ["<C-CR>"] = cmp.mapping.confirm { select = true }, -- Insert
            ["<S-BS>"] = exit_completion, -- My Caps is BS cuz caps is bs.
            ["<S-Tab>"] = toggle_docs,
            ["<C-N>"] = cmp.mapping.scroll_docs(4),
            ["<C-E>"] = cmp.mapping.scroll_docs(-4),
            ["<C-L>"] = cmp.mapping.complete_common_string() -- TODO
        },
        formatting = { -- TODO
            expandable_indicator = true,
            fields = { "abbr", "kind", "menu" },
            format = function(_, vim_item)
                return vim_item
            end,
        },
        sources = {
            { name = "nvim_lsp", group_index = 1 },
            { name = "luasnip",  group_index = 1 },
            { name = "buffer",   group_index = 2, option = {
                indexing_interval = 100, -- default 100 ms
                indexing_batch_size = 500, -- default 1000 lines
                max_indexed_line_length = 2048, -- default 40*1024 bytes
                get_bufnrs = get_completion_buffers
            } }
        },
        window = {
            completion = cmp.config.window.bordered {
                side_padding = 0,
                scrollbar = false,
                border = require("assets").border_bleed
            },
            documentation = cmp.config.window.bordered {
                side_padding = 0,
                border = require("assets").border_bleed
            }
        },
        --experimental = { ghost_text = true }
    }
end

return M
