return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
        build = ":TSUpdate",
        event = "VeryLazy", -- don't slow down startup
        opts = {
            auto_install = true,
            sync_install = false,
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
            -- MODULES
            highlight = { enable = true },
            indent = { enable = true }, -- for the `=` formatting
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<tab>",
                    node_incremental = "<tab>",
                    node_decremental = "<s-tab>",
                    scope_incremental = "<c-tab>",
                },
            },
            textobjects = {
                select = { -- TODO
                    enable = false,
                    lookahead = true,
                    keymaps = {},
                },
                swap = {
                    enable = true,
                    swap_next = { ["<leader>s"] = "@parameter.inner" },
                    swap_previous = { ["<leader>S"] = "@parameter.inner" },
                },
                move = { -- TODO
                    enable = false,
                    set_jumps = true,
                },
            }
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
