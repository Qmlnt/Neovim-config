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
                "arduino",
                "bash",
                "c",
                "cmake",
                "comment",
                "cpp",
                "c_sharp",
                "diff",
                "haskell",
                "html",
                "javascript",
                "json",
                "jsonc",
                "lua",
                "luadoc",
                "luap",
                "make",
                "markdown",
                "markdown_inline",
                "ninja",
                "python",
                "query",
                "regex",
                "rust",
                "toml",
                "vim",
                "vimdoc",
                "yaml"
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },


}
