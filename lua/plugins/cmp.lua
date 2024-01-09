local M = {
    "hrsh7th/nvim-cmp",
    --event = "VeryLazy",
    event = { "InsertEnter" }, -- , "CmdlineEnter"
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",

        "L3MON4D3/LuaSnip", -- jsregexp is optional
        "saadparwaiz1/cmp_luasnip",
    }
}


local kinds = {
    Enum = " Enum",
    File = " File",
    Text = " Text",
    Unit = "󰑭 Unit",
    Class = " Class",
    Color = " Color",
    Event = " Event",
    Field = " Field",
    Value = "󰎠 Value",
    Folder = " Path",
    Method = " Methd",
    Module = " Modle",
    Struct = "󰙅 Strct",
    Keyword = "󰌋 Kword",
    Snippet = " Snipp",
    Constant = "󰏿 Const",
    Function = "󰊕 Func",
    Operator = " Oper",
    Property = " Prop",
    Variable = " Var",
    Interface = " Itrfc",
    Reference = "󰈇 Rfrnc",
    EnumMember = " EnMem",
    Constructor = "🏗 Cstctr",
    TypeParameter = " TpPrm",
}


local function format_completion_entries(entry, vim_item) -- :h complete-items
    vim_item.menu = ({
        buffer = "[Buf]",
        luasnip = "[LS]",
        nvim_lsp = "[LSP]",
    })[entry.source.name]
    vim_item.kind = kinds[vim_item.kind] or "?"
    return vim_item
end


-- Close the damn completion window
---@return true
local function exit_completion()
    vim.api.nvim_feedkeys("gi", "n", false)
    return true
end

---@return true
local function register_oneshots()
    local oneshot_keymap = require("assets").oneshot_keymap
    for _, key in ipairs { "<CR>", "<Tab>", "<Space>", "<Down>", "<Up>", "<Left>", "<Right>" } do
        local keys = vim.api.nvim_replace_termcodes(key, true, false, true)
        oneshot_keymap("i", key, function()
            exit_completion()
            vim.api.nvim_feedkeys(keys, "n", false)
        end, { buffer = 0 })
    end
    return true
end

local function get_completion_buffers()
    local buffers = {}
    for _, win_id in ipairs(vim.api.nvim_list_wins()) do -- only visible buffers
        local buf_id = vim.api.nvim_win_get_buf(win_id)
        local buf_lines = vim.api.nvim_buf_line_count(buf_id)
        local buf_bytes = vim.api.nvim_buf_get_offset(buf_id, buf_lines)

        if buf_bytes < 524288 then -- 512 KiB
            table.insert(buffers, buf_id)
        end
    end
    return buffers
end


local function longest_common_completion(cmp)
    -- TODO use most common instead of just common
    cmp.complete { config = { -- should be fast asf
        sources = {
            { name = "nvim_lsp" },
            { name = "buffer", option = {
                get_bufnrs = get_completion_buffers } }
        },
        performance = {
            throttle = 0,
            debounce = 15,
            max_view_entries = 10,
            fetching_timeout = 100
        },
        preselect = cmp.PreselectMode.None, -- not to mess up common_string
        formatting = { format = false }
    } }
    return cmp.complete_common_string()
end

local function setup_mappings(cmp)
    local mappings = { -- My Caps is BS cuz caps is bs.
        ["<C-N>"] = cmp.mapping.scroll_docs(4),
        ["<C-E>"] = cmp.mapping.scroll_docs(-4),
        ["<C-Space>"] = cmp.mapping.select_prev_item(),
        ["<C-CR>"] = cmp.mapping.confirm { select = true }, -- Insert
    }

    -- and = exec if prev=true; or = exec if prev=false
    mappings["<S-Tab>"] = function()
        return cmp.visible and cmp.open_docs() or cmp.close_docs()
    end
    mappings["<S-BS>"] = cmp.mapping(function()
        return cmp.visible() and exit_completion()
        or require("luasnip").expand_or_jump()
    end, { "i", "s" })
    mappings["<C-BS>"] = cmp.mapping(function()
        return cmp.visible() and cmp.abort() and exit_completion()
        or require("luasnip").jump(-1)
    end, { "i", "s" })
    -- it's that simple and that hard
    mappings["<S-Space>"] = function()
        return (cmp.visible() or (
            cmp.complete() and register_oneshots() and not cmp.get_selected_entry()
        )) and cmp.select_next_item()
    end
    mappings["<S-CR>"] = function()
        return cmp.visible()
            and cmp.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace }
            or longest_common_completion(cmp) and exit_completion() or register_oneshots()
    end

    return mappings
end


function M.config()
    local cmp = require "cmp"

    cmp.setup.global { -- = cmp.setup
        completion = {
            autocomplete = false,
            completeopt = "menu,menuone,noselect" -- noselect for complete_common_string
        },
        performance = {
            --debounce = 60,
            throttle = 15, -- 30
            --fetching_timeout = 500,
            max_view_entries = 40, -- 200
        },
        mapping = setup_mappings(cmp),
        preselect = cmp.PreselectMode.Item, -- Honour LSP preselect requests
        --experimental = { ghost_text = true }
        snippet = {
            expand = function(args) require("luasnip").lsp_expand(args.body) end
        },
        formatting = {
            expandable_indicator = true,
            fields = { "abbr", "kind", "menu" },
            format = format_completion_entries,
        },
        view = {
            docs = { auto_open = true },
            entries = { name = "custom", selection_order = "near_cursor" }
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
        }
    }
end

return M
