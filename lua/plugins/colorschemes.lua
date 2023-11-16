return {
    {
        "folke/tokyonight.nvim",
        lazy = false,    -- for priority to work
        priority = 1000, -- load before all other start plugins
        opts = { style = "night" },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme "tokyonight"
        end
    },

    { "navarasu/onedark.nvim", lazy = true }
}
