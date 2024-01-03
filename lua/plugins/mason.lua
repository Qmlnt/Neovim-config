return {
    "williamboman/mason.nvim",
    lazy = true, -- lazy-loading not recommended tho
    opts = {
        ui = {
            height = 0.8,
            border = require("assets").border,
            icons = {
                package_pending = "󱦳",
                package_installed = "",
                package_uninstalled = "⤫"
            }
        }
    }
}
