local M = {
    "hrsh7th/nvim-cmp",
    --event = "VeryLazy",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",

        "L3MON4D3/LuaSnip", -- jsregexp?
        "saadparwaiz1/cmp_luasnip",

    }
}


local function trigger_completion(cmp)
    return function()
        if cmp.visible() then
            return cmp.select_prev_item()
        end

        cmp.complete()
        --TEST=vim.inspect(cmp.get_selected_entry())
        cmp.complete_common_string()
    end
end

local function toggle_completion_docs(cmp)
    return function(fallback)
        if not cmp.visible() then
            return fallback()
        end

        if cmp.visible_docs() then
            cmp.close_docs()
        else
            cmp.open_docs()
        end
    end
end

local function get_completion_buffers()
    return { vim.api.nvim_get_current_buf() } --.nvim_list_bufs()
end


function M.config() -- TODO styling of menu
    local cmp = require "cmp"

    cmp.setup.global { -- = cmp.setup
        preselect = cmp.PreselectMode.Item, -- TODO
        completion = { autocomplete = false },
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
        mapping = { -- insert mode by default
            ["<S-Space>"] = trigger_completion(cmp),
            ["<Space>"] = cmp.mapping.select_next_item(),
            ["<C-Space>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm { select = true,
                behavior = cmp.ConfirmBehavior.Replace },
            ["<C-CR>"] = cmp.mapping.confirm { select = true,
                behavior = cmp.ConfirmBehavior.Insert },
            ["<S-CR>"] = cmp.mapping.close(),

            ["<Tab>"] = toggle_completion_docs(cmp),
            ["<C-N>"] = cmp.mapping.scroll_docs(4),
            ["<C-E>"] = cmp.mapping.scroll_docs(-4),
        },
        formatting = { -- TODO
            expandable_indicator = true,
            fields = { "abbr", "kind", "menu" },
            format = function(_, vim_item)
                return vim_item
            end,
        },
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip"  } },
            { { name = "buffer", option = { get_bufnrs = get_completion_buffers } } }
        )
    }
end

return M
