return {
    "nvim-treesitter/nvim-treesitter",
    event = "User LazyFile",
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function() require "configs.treesitter" end
}
