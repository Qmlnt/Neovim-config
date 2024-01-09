local M = {
    "nvim-treesitter/nvim-treesitter",
    event = "User HalfLazy",
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" }
}


local treesitter_config = {
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
    indent = { enable = true }, -- for the `=` formatting
    highlight = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<tab>",
            node_incremental = "<tab>",
            node_decremental = "<s-tab>",
            scope_incremental = "<c-tab>",
        }
    }
}

treesitter_config.textobjects = {
    select = {
        enable = true,
        lookahead = true, -- look for an object futher in the file
        include_surrounding_whitespace = false, -- disabled for Python
        keymaps = { -- i - invocation, o - object, n - note, a - argument
            ["ai"] = "@call.outer", ["ic"] = "@conditional.inner",
            ["al"] = "@loop.outer",   ["ia"] = "@parameter.inner",
            ["ab"] = "@block.outer",   ["if"] = "@function.inner",
            ["ao"] = "@class.outer",    ["in"] = "@comment.inner",
            ["ar"] = "@return.outer",    ["ir"] = "@return.inner",
            ["an"] = "@comment.outer",    ["io"] = "@class.inner",
            ["af"] = "@function.outer",   ["ib"] = "@block.inner",
            ["aa"] = "@parameter.outer",   ["il"] = "@loop.inner",
            ["ac"] = "@conditional.outer", ["ii"] = "@call.inner",
        }
    },
    swap = {
        enable = true,
        swap_next = { -- a bit too much i guess... XD
            [")i"] = "@call.outer", [")C"] = "@conditional.inner",
            [")l"] = "@loop.outer",   [")A"] = "@parameter.inner",
            [")b"] = "@block.outer",   [")F"] = "@function.inner",
            [")o"] = "@class.outer",    [")N"] = "@comment.inner",
            [")r"] = "@return.outer",    [")R"] = "@return.inner",
            [")n"] = "@comment.outer",    [")O"] = "@class.inner",
            [")f"] = "@function.outer",   [")B"] = "@block.inner",
            [")a"] = "@parameter.outer",   [")L"] = "@loop.inner",
            [")c"] = "@conditional.outer", [")I"] = "@call.inner",
        },
        swap_previous = {
            ["(i"] = "@call.outer", ["(C"] = "@conditional.inner",
            ["(l"] = "@loop.outer",   ["(A"] = "@parameter.inner",
            ["(b"] = "@block.outer",   ["(F"] = "@function.inner",
            ["(o"] = "@class.outer",    ["(N"] = "@comment.inner",
            ["(r"] = "@return.outer",    ["(R"] = "@return.inner",
            ["(n"] = "@comment.outer",    ["(O"] = "@class.inner",
            ["(f"] = "@function.outer",   ["(B"] = "@block.inner",
            ["(a"] = "@parameter.outer",   ["(L"] = "@loop.inner",
            ["(c"] = "@conditional.outer", ["(I"] = "@call.inner",
        },
    },
    move = {
        enable = true,
        set_jumps = true, -- <C-o> back, <C-i> forward
        goto_next     = {},
        goto_previous = {},
        goto_next_start = {
            ["]i"] = "@call.outer", ["]c"] = "@conditional.outer",
            ["]l"] = "@loop.outer",  ["]s"] = "@assignment.inner",
            ["]b"] = "@block.outer",  ["]a"] = "@parameter.outer",
            ["]o"] = "@class.outer",   ["]f"] = "@function.outer",
            ["]r"] = "@return.outer",   ["]n"] = "@comment.outer",
        },
        goto_next_end = {
            ["]I"] = "@call.outer", ["]C"] = "@conditional.outer",
            ["]L"] = "@loop.outer",  ["]S"] = "@assignment.inner",
            ["]B"] = "@block.outer",  ["]A"] = "@parameter.outer",
            ["]O"] = "@class.outer",   ["]F"] = "@function.outer",
            ["]R"] = "@return.outer",   ["]N"] = "@comment.outer",
        },
        goto_previous_start = {
            ["[i"] = "@call.outer", ["[c"] = "@conditional.outer",
            ["[l"] = "@loop.outer",  ["[s"] = "@assignment.inner",
            ["[b"] = "@block.outer",  ["[a"] = "@parameter.outer",
            ["[o"] = "@class.outer",   ["[f"] = "@function.outer",
            ["[r"] = "@return.outer",   ["[n"] = "@comment.outer",
        },
        goto_previous_end = {
            ["[I"] = "@call.outer", ["[C"] = "@conditional.outer",
            ["[L"] = "@loop.outer",  ["[S"] = "@assignment.inner",
            ["[B"] = "@block.outer",  ["[A"] = "@parameter.outer",
            ["[O"] = "@class.outer",   ["[F"] = "@function.outer",
            ["[R"] = "@return.outer",   ["[N"] = "@comment.outer",
        },
    },
    lsp_interop = {
        enable = true,            -- vim.lsp.util.open_floating_preview
        floating_preview_opts = { border = require("assets").border_bleed },
        peek_definition_code = {
            ["<Leader>lpo"] = { query = "@class.outer", desc = "Class" },
            ["<Leader>lpf"] = { query = "@function.outer", desc = "Function" },
            ["<Leader>lps"] = { query = "@assignment.outer", desc = "Assignment" },
        },
    },
}


function M.config()
    require("nvim-treesitter.configs").setup(treesitter_config)

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
end

return M
