return {
    "nvim-telescope/telescope.nvim", branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    keys = { -- so lazy 🥱
        { "<Leader>s", desc = "Load Telescope", mode = { "n", "x" } },
        -- { "<Leader>o", desc = "Find old files" },
        { "<Leader>.", desc = "Find files in ." },
        { "<Leader>/", desc = "Telescope /" },
        { "<Leader>f", desc = "Find files" },
    },
    config = function() require "configs.telescope" end
}
