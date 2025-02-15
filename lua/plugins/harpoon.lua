return {
    "ThePrimeagen/harpoon", branch = "harpoon2",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
        { "<Leader>a", desc = "Append harpoon" },
        { "<Leader>A", desc = "Prepend harpoon" },
        { "<Leader>m", desc = "Harpoon menu" },
        { "<Leader>M", desc = "Harpoon clear" },
        "<C-n>", "<C-p>", "]m", "[m",
        "ñ", "é", "í", "ó", -- AltGr Colemak layer
    },
    config = function()
        local harpoon = require "harpoon"
        harpoon:setup()

        Lmap("a", function() harpoon:list():append() end)
        Lmap("A", function() harpoon:list():prepend() end)
        Lmap("m", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        Lmap("M", function() harpoon:list():clear() end)
        MakePair("m", "harpoon", function() harpoon:list():next() end, function() harpoon:list():prev() end)

        local map = vim.keymap.set
        map("n", "<C-p>", function() harpoon:list():prev() end)
        map("n", "<C-n>", function() harpoon:list():next() end)
        -- TODO ._.
        map("n", "ñ", function() harpoon:list():select(1) end)
        map("n", "é", function() harpoon:list():select(2) end)
        map("n", "í", function() harpoon:list():select(3) end)
        map("n", "ó", function() harpoon:list():select(4) end)
    end
}
