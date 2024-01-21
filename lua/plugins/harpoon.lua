return {
    "ThePrimeagen/harpoon", branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<Leader>a", desc = "Append harpoon" },
        { "<Leader>A", desc = "Prepend harpoon" },
        { "<Leader>m", desc = "Harpoon menu" },
        { "<Leader>M", desc = "Harpoon clear" },
        "<C-p>", "<C-n>", "<C-1", "<C-2>", "<C-3>", "<C-4>",
    },
    config = function()
        local harpoon = require "harpoon"
        harpoon:setup()

        Lmap("a", function() harpoon:list():append() end)
        Lmap("A", function() harpoon:list():prepend() end)
        Lmap("m", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        Lmap("M", function() harpoon:list():clear() end)

        local map = vim.keymap.set
        map("n", "<C-p>", function() harpoon:list():prev() end)
        map("n", "<C-n>", function() harpoon:list():next() end)
        -- TODO ._.
        map("n", "<C-1>", function() harpoon:list():select(1) end)
        map("n", "<C-2>", function() harpoon:list():select(2) end)
        map("n", "<C-3>", function() harpoon:list():select(3) end)
        map("n", "<C-4>", function() harpoon:list():select(4) end)
    end
}
