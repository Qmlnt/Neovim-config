return {
    "williamboman/mason.nvim",
    lazy = false, -- lazy-loading not recommended
    opts = {
        ui = {
            height = 0.8,
            border = "single",
            icons = {
                package_pending = "󰦗",
                package_installed = "",
                package_uninstalled = "⤫"
            }
        }
    }
}
