return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        window = {
            border = require("assets.assets").border,
            padding = { 0, 1, 0, 1 } -- ^, <, _, >
        },
        layout = {
            spacing = 4,
            align = "center",
            width = { min = 1 },
            height = { min = 1, max = 15 }
        },
        key_labels = { ["<leader>"] = "L" },
        plugins = { spelling = { suggestions = 40 } },
    },

    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 400 -- before opening WhichKey
    end,

    config = function(_, opts)
        require("which-key").setup(opts)
        require("which-key").register({ -- Naming groups here
            c =  { name = "Quickfix" },
            C =  { name = "Loclist" },
            u  = { name = "Utils" },
            t  = { name = "Toggle" },
            b  = { name = "Buffer" },
            w  = { name = "Window" },
            h  = { name = "Gitsigns",
                v = { name = "View" },
                t = { name = "Toggle" },
                c = { name = "Control" },
            },
            l  = {
                name = "LSP",
                l = { name = "List" },
                c = { name = "Control" },
                w = { name = "Workspace" },
                p = { name = "Peek definiton" },
            },
        }, { prefix = "<Leader>" })
    end
}
