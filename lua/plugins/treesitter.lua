return {
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
            select = {
                enable = true,
                lookahead = true, -- look for an object futher in the file
                include_surrounding_whitespace = true, -- succeeding > preceeding
                keymaps = { -- a: around, i: inner  |  a: attribute, i: if
                    ["aa"] = "@parameter.outer",    ["ia"] = "@parameter.inner",
                    ["ai"] = "@conditional.outer",  ["ii"] = "@conditional.inner",
                    ["al"] = "@loop.outer",         ["il"] = "@loop.inner",
                    ["af"] = "@function.outer",     ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",        ["ic"] = "@class.inner",
                },
            },
            swap = {
                enable = true,
                swap_next     = { ["<leader>a"] = "@parameter.inner" },
                swap_previous = { ["<leader>A"] = "@parameter.inner" },
            },
            move = {
                enable = true,
                set_jumps = true, -- <C-o> back, <C-i> (=Tab which I remapped '>.<) forward
                goto_next           = { ["]p"] = "@parameter.outer" },
                goto_previous       = { ["[p"] = "@parameter.outer" },
                goto_next_start     = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]r"] = "@comment.outer" },
                goto_next_end       = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
                goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[r"] = "@comment.outer" },
                goto_previous_end   = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
            },
        },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
