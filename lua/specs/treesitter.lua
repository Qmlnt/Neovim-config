return {
    "nvim-treesitter/nvim-treesitter",
    event = "User HalfLazy", -- "VeryLazy" },
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function() require "setups.treesitter" end
}
