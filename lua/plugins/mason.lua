return {
    "williamboman/mason.nvim",
    opts = {
        ui = {
            height = 0.8,
            border = vim.g.border,
            icons = {
                package_pending = "󱦳",
                package_installed = "",
                package_uninstalled = "⤫"
            }
        }
    }
}
