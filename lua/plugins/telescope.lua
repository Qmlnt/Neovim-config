-- TODO read the docu instead of somehow making it worku?
return {
    "nvim-telescope/telescope.nvim", branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    keys = { -- so lazy 🥱
        { "<Leader>s", desc = "Load Telescope", mode = { "n", "x" } },
        { "<Leader>f", desc = "Find files" },
        { "<Leader>.", desc = "Find . files" },
        { "<Leader>/", desc = "Telescope /" },
    },
    config = function() require "configs.telescope" end
}
