return {
    {
        "folke/tokyonight.nvim",
        lazy = false,    -- for priority to work
        priority = 1000, -- load before all other start plugins
        --opts = { style = "night" },
        config = function() vim.cmd.colorscheme "tokyonight-night" end
    },

    { "navarasu/onedark.nvim", lazy = true }
}
