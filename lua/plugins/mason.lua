return {
    "williamboman/mason.nvim",
    opts = {
        ui = {
            height = 0.8,
            border = require("assets.assets").border,
            icons = {
                package_pending = "󱦳",
                package_installed = "",
                package_uninstalled = "⤫"
            }
        }
    }
}
