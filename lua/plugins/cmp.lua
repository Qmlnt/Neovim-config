local M = {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",

        "L3MON4D3/LuaSnip", -- jsregexp?
        "saadparwaiz1/cmp_luasnip",

    }
}

local function trigger_completion(cmp)
    return function()
        if cmp.visible() then
            cmp.select_prev_item()
        else
            cmp.complete()
            --cmp.complete_common_string()
        end
    end
end

function M.config()
    local cmp = require "cmp"

    cmp.setup {
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        completion = { autocomplete = false },
        mapping = cmp.mapping.preset.insert {
            ["<S-Space>"] = trigger_completion(cmp),
            ["<C-Space>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm { select = true },
            ["<Space>"] = cmp.mapping.select_next_item(),
            ["<S-CR>"] = cmp.mapping.close(),
        },

        sources = cmp.config.sources {
            { name = "nvim_lsp" },
            { name = "luasnip"  }
        }
    }
end

return M
