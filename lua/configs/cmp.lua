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
---@return true
local function exit_completion()
    vim.api.nvim_feedkeys("gi", "n", false)
    return true
end

---@return true
local function register_oneshots()
    for _, key in ipairs { "<CR>", "<Tab>", "<Space>", "<Down>", "<Up>", "<Left>", "<Right>" } do
        vim.keymap.set("i", key, function()
            exit_completion()
            vim.keymap.del("i", key, { buffer = 0 })
            return key
        end, { buffer = 0, expr = true })
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


local function longest_common_completion()
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

local function setup_mappings()
    local mappings = { -- My Caps is BS cuz caps is bs.
        ["<C-n>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.scroll_docs(-4),
        ["<C-Space>"] = function() cmp.select_prev_item() end,
        ["<C-CR>"] = function() cmp.confirm { select = true } end, -- Insert
    }

    -- and = exec if prev=true; or = exec if prev=false
    mappings["<S-Tab>"] = function()
        return cmp.visible() and cmp.open_docs() or cmp.close_docs()
    end
    mappings["<S-BS>"] = cmp.mapping(function()
        return cmp.visible() and exit_completion()
            or luasnip.expand_or_jump()
    end, { "i", "s" })
    mappings["<C-BS>"] = cmp.mapping(function()
        return cmp.visible() and cmp.abort() and exit_completion()
            or luasnip.jump(-1)
    end, { "i", "s" })
    -- it's that simple and that hard
    mappings["<S-Space>"] = function() -- in my kitty.conf: map shift+space send_text all \033[32;2u
        return (cmp.visible() or (
            cmp.complete() and register_oneshots() and not cmp.get_selected_entry()
        )) and cmp.select_next_item()
    end
    mappings["<S-CR>"] = function()
        return cmp.visible()
            and cmp.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace }
            or longest_common_completion() and exit_completion() or register_oneshots()
    end

    return mappings
end


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
    mapping = setup_mappings(),
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
            border = require("assets.assets").border_bleed
        },
        documentation = cmp.config.window.bordered {
            side_padding = 0,
            border = require("assets.assets").border_bleed
        }
    }
}
