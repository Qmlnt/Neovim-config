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
                include_surrounding_whitespace = false, -- disabled for Python
                keymaps = { -- a: around, i: inner
                    ["ap"] = "@parameter.outer",   ["ip"] = "@parameter.inner",
                    ["ac"] = "@conditional.outer", ["ic"] = "@conditional.inner",
                    ["al"] = "@loop.outer",        ["il"] = "@loop.inner",
                    ["af"] = "@function.outer",    ["if"] = "@function.inner",
                    ["ao"] = "@class.outer",       ["io"] = "@class.inner",
                    ["an"] = "@comment.outer",     ["in"] = "@comment.inner",
                },
            },
            swap = {
                enable = true,
                swap_next     = { ["<leader>tp"] = "@parameter.inner", ["<leader>tf"] = "@function.outer" },
                swap_previous = { ["<leader>tP"] = "@parameter.inner", ["<leader>tF"] = "@function.outer" },
            },
            move = {
                enable = true,
                set_jumps = true, -- <C-o> back, <C-i> (=Tab which I remapped '>.<) forward
                goto_next           = { ["]p"] = "@parameter.outer", ["]a"] = "@assignment" },
                goto_previous       = { ["[p"] = "@parameter.outer", ["[a"] = "@assignment" },
                goto_next_start     = { ["]f"] = "@function.outer",  ["]o"] = "@class.outer", ["]n"] = "@comment.outer" },
                goto_next_end       = { ["]F"] = "@function.outer",  ["]O"] = "@class.outer" },
                goto_previous_start = { ["[f"] = "@function.outer",  ["[o"] = "@class.outer", ["[n"] = "@comment.outer" },
                goto_previous_end   = { ["[F"] = "@function.outer",  ["[O"] = "@class.outer" },
            },
            lsp_interop = { --TODO
                enable = false,
                border = 'none',
                floating_preview_opts = {},
                peek_definition_code = {
                    ["<leader>df"] = "@function.outer",
                    ["<leader>do"] = "@class.outer",
                },
            },
        },
    },

    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
        local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
    end,
}
