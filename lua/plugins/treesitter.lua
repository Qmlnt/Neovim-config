return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "VeryLazy", -- wait till UI loads
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            auto_install = true,
            sync_install = false, -- only for ensure_installed
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "diff",
                "html",
                --"javascript",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "toml",
                "vim",
                "vimdoc",
                "yaml",
                "comment"
            }
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },


}
