return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter", -- , "CmdlineEnter"
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",

        {
            "L3MON4D3/LuaSnip", -- jsregexp is optional
            dependencies = "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end
        },
        "saadparwaiz1/cmp_luasnip", -- TODO
    },
    config = function() require "configs.cmp" end
}
