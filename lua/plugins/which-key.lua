return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        win = {
            border = vim.g.border,
            padding = { 0, 1, 0, 1 } -- ^, <, _, >
        },
        layout = {
            spacing = 4,
            align = "center",
            width = { min = 1 },
            height = { min = 1, max = 15 }
        },
        replace = { ["<leader>"] = "L" },
        plugins = { spelling = { suggestions = 40 } },
    },

    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 400 -- before opening WhichKey
    end,

    config = function(_, opts)
        require("which-key").setup(opts)
        require("which-key").add({ -- Naming groups here
            { "<Leader>C",  group = "Loclist" },
            { "<Leader>b",  group = "Buffer" },
            { "<Leader>c",  group = "Quickfix" },
            { "<Leader>h",  group = "Gitsigns" },
            { "<Leader>hc", group = "Control" },
            { "<Leader>ht", group = "Toggle" },
            { "<Leader>hv", group = "View" },
            { "<Leader>l",  group = "LSP" },
            { "<Leader>lc", group = "Control" },
            { "<Leader>ll", group = "List" },
            { "<Leader>lp", group = "Peek definiton" },
            { "<Leader>lw", group = "Workspace" },
            { "<Leader>t",  group = "Toggle" },
            { "<Leader>u",  group = "Utils" },
            { "<Leader>w",  group = "Window" },

            -- c =  { name = "Quickfix" },
            -- C =  { name = "Loclist" },
            -- u  = { name = "Utils" },
            -- t  = { name = "Toggle" },
            -- b  = { name = "Buffer" },
            -- w  = { name = "Window" },
            -- h  = { name = "Gitsigns",
            --     v = { name = "View" },
            --     t = { name = "Toggle" },
            --     c = { name = "Control" },
            -- },
            -- l  = {
            --     name = "LSP",
            --     l = { name = "List" },
            --     c = { name = "Control" },
            --     w = { name = "Workspace" },
            --     p = { name = "Peek definiton" },
            -- },
            -- }, { prefix = "<Leader>" })
        })
    end
}
