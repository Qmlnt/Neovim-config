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
        require("which-key").register({
            u  = "Utils",
            t  = "Toggle",
            b  = "Buffer",
            w  = "Window",
            l  = "LSP",
            ll = "List",
            lg = "Go to",
            lc = "Control",
            lw = "Workspace",
            ld = "Diagnostics",
            lp = "Peek definiton",
            h  = "Gitsigns",
            ht = "Toggle",
            hc = "Control",
            hv = "View ver",
            hd = "Diff with",
        }, { prefix = "<Leader>" })
    end
}
