return {
    lazy = true,
    "hrsh7th/nvim-cmp",
    dependencies = {
        "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path",
        "rafamadriz/friendly-snippets",
    },
    opts = {},

    config = function(_, opts)
        local cmp = require("cmp")

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            window = {
                -- completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<S-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources(
                {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                },
                { { name = "buffer" } })
        })

    end
}
