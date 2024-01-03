return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
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
            "yaml",
        },
        --      MODULES
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
                keymaps = { -- i - invocation, o - object, n - note, a - argument
                    ["ai"] = "@call.outer",        ["ii"] = "@call.inner",
                    ["al"] = "@loop.outer",        ["il"] = "@loop.inner",
                    ["ab"] = "@block.outer",       ["ib"] = "@block.inner",
                    ["ao"] = "@class.outer",       ["io"] = "@class.inner",
                    ["ar"] = "@return.outer",      ["ir"] = "@return.inner",
                    ["an"] = "@comment.outer",     ["in"] = "@comment.inner",
                    ["af"] = "@function.outer",    ["if"] = "@function.inner",
                    ["aa"] = "@parameter.outer",   ["ia"] = "@parameter.inner",
                    ["ac"] = "@conditional.outer", ["ic"] = "@conditional.inner",
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    [")i"] = "@call.outer", [")c"] = "@conditional.outer",
                    [")l"] = "@loop.outer",   [")a"] = "@parameter.inner",
                    [")b"] = "@block.outer",   [")f"] = "@function.outer",
                    [")o"] = "@class.outer",     [")r"] = "@return.outer",
                },
                swap_previous = {
                    ["(i"] = "@call.outer", ["(c"] = "@conditional.outer",
                    ["(l"] = "@loop.outer",   ["(a"] = "@parameter.inner",
                    ["(b"] = "@block.outer",   ["(f"] = "@function.outer",
                    ["(o"] = "@class.outer",     ["(r"] = "@return.outer",
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- <C-o> back, <C-i> forward
                goto_next     = { ["]i"] = "@call.outer" },
                goto_previous = { ["[i"] = "@call.outer" },
                goto_next_start = {
                    ["]l"] = "@loop.outer", ["]c"] = "@conditional.outer",
                    ["]b"] = "@block.outer",  ["]a"] = "@parameter.outer",
                    ["]o"] = "@class.outer",   ["]f"] = "@function.outer",
                    ["]r"] = "@return.outer",   ["]n"] = "@comment.outer",
                },
                goto_next_end = {
                    ["]L"] = "@loop.outer", ["]C"] = "@conditional.outer",
                    ["]B"] = "@block.outer",  ["]A"] = "@parameter.outer",
                    ["]O"] = "@class.outer",   ["]F"] = "@function.outer",
                    ["]R"] = "@return.outer",   ["]N"] = "@comment.outer",
                },
                goto_previous_start = {
                    ["[l"] = "@loop.outer", ["[c"] = "@conditional.outer",
                    ["[b"] = "@block.outer",  ["[a"] = "@parameter.outer",
                    ["[o"] = "@class.outer",   ["[f"] = "@function.outer",
                    ["[r"] = "@return.outer",   ["[n"] = "@comment.outer",
                },
                goto_previous_end = {
                    ["[L"] = "@loop.outer", ["[C"] = "@conditional.outer",
                    ["[B"] = "@block.outer",  ["[A"] = "@parameter.outer",
                    ["[O"] = "@class.outer",   ["[F"] = "@function.outer",
                    ["[R"] = "@return.outer",   ["[N"] = "@comment.outer",
                },
            },
            lsp_interop = { --TODO
                enable = true,
                floating_preview_opts = { -- vim.lsp.util.open_floating_preview
                    border = require("assets").border_bleed
                },
                peek_definition_code = {
                    ["<Leader>lpo"] = { query = "@class.outer", desc = "Class" },
                    ["<Leader>lpf"] = { query = "@function.outer", desc = "Function" },
                },
            },
        },
    },

    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)

        local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
        -- repeat other moves
        local next_diagnostics, prev_diagnostics =
        ts_repeat_move.make_repeatable_move_pair(vim.diagnostic.goto_next, vim.diagnostic.goto_prev)
        vim.keymap.set("n", "]d", next_diagnostics, { desc = "Next diagnostic (repeatable)" })
        vim.keymap.set("n", "[d", prev_diagnostics, { desc = "Prev diagnostic (repeatable)" })
    end,
}
