return {
    "nvim-treesitter/nvim-treesitter",
    event = "User LazyFile",
    -- lazy = false, --TODO
    build = ":TSUpdate",
    dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
    init = function()
        vim.o.foldenable = true
        vim.o.foldlevel  = 99
        vim.o.foldmethod = "expr"
        vim.o.foldexpr   = "nvim_treesitter#foldexpr()"
    end,
    config = function() require "configs.treesitter" end
}
