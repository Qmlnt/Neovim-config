local cmp = require "cmp"
local luasnip = require "luasnip"


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
local function exit_completion()
    vim.api.nvim_feedkeys("gi", "n", false)
end

local function register_oneshots()
    for _, key in ipairs { "<CR>", "<Tab>", "<Space>", "<Down>", "<Up>", "<Left>", "<Right>" } do
        vim.keymap.set("i", key, function()
            exit_completion()
            vim.keymap.del("i", key, { buffer = 0 })
            return key
        end, { buffer = 0, expr = true })
    end
end

local function get_completion_buffers()
    local buffers = {}
    for _, win_id in ipairs(vim.api.nvim_list_wins()) do -- only visible buffers
        local buf_id = vim.api.nvim_win_get_buf(win_id)
        local buf_lines = vim.api.nvim_buf_line_count(buf_id)
        local buf_bytes = vim.api.nvim_buf_get_offset(buf_id, buf_lines)

        if buf_bytes < 196608 then -- 192 KiB
            table.insert(buffers, buf_id)
        end
    end
    return buffers
end


-- TODO use most common instead of just common
local function longest_common_completion()
    cmp.complete { config = { -- should be fast asf
        sources = {
            { name = "buffer", option = {
                get_bufnrs = get_completion_buffers } },
            -- { name = "nvim_lsp" }, -- there is other completion for lsp
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


local mappings = {
    ["<C-n>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.scroll_docs(-4),
    -- in my kitty.conf: map shift+space send_text all \033[32;2u
    ["<S-Space>"] = cmp.mapping.select_next_item(),
    ["<C-Space>"] = cmp.mapping.select_prev_item(),
    ["<S-Tab>"] = function()
        if cmp.visible_docs() then
            cmp.close_docs()
        else
            cmp.open_docs()
        end
    end,
    -- My Caps is BS cuz caps is bs.
    ["<S-BS>"] = cmp.mapping(function()
        if cmp.visible() then
            exit_completion()
        else
            luasnip.expand_or_jump()
        end
    end, { "i", "s" }),
    ["<C-BS>"] = cmp.mapping(function()
        if cmp.visible() then
            cmp.abort()
            exit_completion()
        else
            luasnip.jump(-1)
        end
    end, { "i", "s" }),
    ["<S-CR>"] = function()
        if cmp.visible() then
            cmp.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace }
        elseif cmp.complete() then
            register_oneshots()
        end
    end,
    ["<C-CR>"] = function()
        if cmp.visible() then
            cmp.confirm { select = true, behavior = cmp.ConfirmBehavior.Insert }
        elseif longest_common_completion() then
            exit_completion()
        else
            register_oneshots()
        end
    end
}


cmp.setup.global { -- = cmp.setup
    completion = {
        autocomplete = false,
        completeopt = "menu,menuone,noselect" -- noselect for complete_common_string
    },
    performance = {
        --debounce = 60,
        throttle = 15,         -- 30
        --fetching_timeout = 500,
        max_view_entries = 40, -- 200
    },
    mapping = mappings,
    preselect = cmp.PreselectMode.Item, -- Honour LSP preselect requests
    --experimental = { ghost_text = true }
    snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end
    },
    formatting = {
        expandable_indicator = true, -- show ~ indicator
        fields = { "abbr", "kind", "menu" },
        format = format_completion_entries,
    },
    view = {
        docs = { auto_open = true },
        entries = { name = "custom", selection_order = "near_cursor" }
    },
    sources = {
        { name = "nvim_lsp", group_index = 1 },
        { name = "luasnip",  group_index = 2 },
        { name = "buffer", group_index = 2, option = {
            indexing_interval = 100,        -- default 100 ms
            indexing_batch_size = 500,      -- default 1000 lines
            max_indexed_line_length = 2048, -- default 40*1024 bytes
            get_bufnrs = get_completion_buffers
        } }
    },
    window = {
        completion = cmp.config.window.bordered {
            side_padding = 0,
            scrollbar = false,
            border = vim.g.border_bleed
        },
        documentation = cmp.config.window.bordered {
            side_padding = 0,
            border = vim.g.border_bleed
        }
    }
}
