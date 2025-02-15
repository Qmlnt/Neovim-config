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
            init_selection = "<Tab>",
            node_incremental = "<Tab>",
            node_decremental = "<S-Tab>",
            scope_incremental = "<C-Tab>",
        }
    }
}

treesitter_config.textobjects = {
    select = {
        enable = true,
        lookahead = true, -- look for an object further in the file
        include_surrounding_whitespace = false, -- disabled for Python
        keymaps = { -- i - invocation, o - object, n - note, a - argument
            ["ai"] = "@call.outer", ["ic"] = "@conditional.inner",
            ["al"] = "@loop.outer",   ["ia"] = "@parameter.inner",
            ["ak"] = "@block.outer",   ["if"] = "@function.inner",
            ["ao"] = "@class.outer",    ["in"] = "@comment.inner",
            ["ar"] = "@return.outer",    ["ir"] = "@return.inner",
            ["an"] = "@comment.outer",    ["io"] = "@class.inner",
            ["af"] = "@function.outer",   ["ik"] = "@block.inner",
            ["aa"] = "@parameter.outer",   ["il"] = "@loop.inner",
            ["as"] = "@assignment.outer",  -- TODO
            ["ac"] = "@conditional.outer", ["ii"] = "@call.inner",
        }
    },
    swap = {
        enable = true,
        swap_next = { -- a bit too much i guess... XD
            [")i"] = "@call.inner", [")C"] = "@conditional.outer",
            [")l"] = "@loop.inner",   [")A"] = "@parameter.outer",
            [")k"] = "@block.inner",   [")F"] = "@function.outer",
            [")o"] = "@class.inner",    [")N"] = "@comment.outer",
            [")r"] = "@return.inner",    [")R"] = "@return.outer",
            [")n"] = "@comment.inner",    [")O"] = "@class.outer",
            [")f"] = "@function.inner",   [")K"] = "@block.outer",
            [")a"] = "@parameter.inner",   [")L"] = "@loop.outer",
            [")c"] = "@conditional.inner", [")I"] = "@call.outer",
        },
        swap_previous = {
            ["(i"] = "@call.inner", ["(C"] = "@conditional.outer",
            ["(l"] = "@loop.inner",   ["(A"] = "@parameter.outer",
            ["(k"] = "@block.inner",   ["(F"] = "@function.outer",
            ["(o"] = "@class.inner",    ["(N"] = "@comment.outer",
            ["(r"] = "@return.inner",    ["(R"] = "@return.outer",
            ["(n"] = "@comment.inner",    ["(O"] = "@class.outer",
            ["(f"] = "@function.inner",   ["(K"] = "@block.outer",
            ["(a"] = "@parameter.inner",   ["(L"] = "@loop.outer",
            ["(c"] = "@conditional.inner", ["(I"] = "@call.outer",
        },
    },
    move = {
        enable = true,
        set_jumps = true, -- <C-o> back, <C-i> forward
        goto_next     = {},
        goto_previous = {},
        goto_next_start = {
            ["]i"] = "@call.outer", ["]c"] = "@conditional.outer",
            ["]l"] = "@loop.outer",  -- ["]s"] = "@assignment.inner",
            ["]k"] = "@block.outer",  ["]a"] = "@parameter.outer",
            ["]o"] = "@class.outer",   ["]f"] = "@function.outer",
            ["]r"] = "@return.outer",   ["]n"] = "@comment.outer",
        },
        goto_next_end = {
            ["]I"] = "@call.outer", ["]C"] = "@conditional.outer",
            ["]L"] = "@loop.outer",  -- ["]S"] = "@assignment.inner",
            ["]K"] = "@block.outer",  ["]A"] = "@parameter.outer",
            ["]O"] = "@class.outer",   ["]F"] = "@function.outer",
            ["]R"] = "@return.outer",   ["]N"] = "@comment.outer",
        },
        goto_previous_start = {
            ["[i"] = "@call.outer", ["[c"] = "@conditional.outer",
            ["[l"] = "@loop.outer",  -- ["[s"] = "@assignment.inner",
            ["[k"] = "@block.outer",  ["[a"] = "@parameter.outer",
            ["[o"] = "@class.outer",   ["[f"] = "@function.outer",
            ["[r"] = "@return.outer",   ["[n"] = "@comment.outer",
        },
        goto_previous_end = {
            ["[I"] = "@call.outer", ["[C"] = "@conditional.outer",
            ["[L"] = "@loop.outer",  -- ["[S"] = "@assignment.inner",
            ["[K"] = "@block.outer",  ["[A"] = "@parameter.outer",
            ["[O"] = "@class.outer",   ["[F"] = "@function.outer",
            ["[R"] = "@return.outer",   ["[N"] = "@comment.outer",
        },
    },
    lsp_interop = {
        enable = true,            -- vim.lsp.util.open_floating_preview
        floating_preview_opts = { border = vim.g.border_bleed },
        peek_definition_code = {
            ["<Leader>lpo"] = { query = "@class.outer", desc = "Object" },
            ["<Leader>lpf"] = { query = "@function.outer", desc = "Function" },
            ["<Leader>lpa"] = { query = "@parameter.inner", desc = "Parameter" },
            ["<Leader>lps"] = { query = "@assignment.outer", desc = "Assignment" },
        },
    },
}

require("nvim-treesitter.configs").setup(treesitter_config)


local map = vim.keymap.set
local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
map({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, {expr=true})
map({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, {expr=true})
map({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, {expr=true})
map({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, {expr=true})
map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
