return {
    "hrsh7th/nvim-cmp",
    --event = "VeryLazy",
    event = "InsertEnter", -- , "CmdlineEnter"
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",

        "L3MON4D3/LuaSnip", -- jsregexp is optional
        "saadparwaiz1/cmp_luasnip", -- TODO
    },
    config = function() require "setups.cmp" end
}
