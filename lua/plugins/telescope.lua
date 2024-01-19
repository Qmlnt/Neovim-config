-- TODO read the docu instead of somehow making it worku?
return {
    "nvim-telescope/telescope.nvim", branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    init = function()
        Lmap("s", "nx", "Load telescope", function() -- so lazy
            vim.keymap.del({ "n", "x" }, "<Leader>s")
            require "configs.telescope"
            vim.schedule_wrap(vim.api.nvim_feedkeys)(vim.g.mapleader.."s", "m", false)
        end)
    end
}
