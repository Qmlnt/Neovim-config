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
            c =  "Qlist",
            C =  "Llist",
            u  = "Utils",
            t  = "Toggle",
            b  = "Buffer",
            w  = "Window",
            l  = "LSP",
            ll = "List",
            lc = "Control",
            lw = "Workspace",
            lp = "Peek definiton",
            h  = "Gitsigns",
            hv = "View",
            ht = "Toggle",
            hc = "Control",
        }, { prefix = "<Leader>" })
    end
}
