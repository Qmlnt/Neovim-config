return {
    {
        "williamboman/mason.nvim",
        lazy = true, -- lazy-loading not recommended tho
        opts = {
            ui = {
                height = 0.8,
                border = "single",
                icons = {
                    package_pending = "",
                    package_installed = "",
                    package_uninstalled = "⤫"
                }
            }
        }
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "mason.nvim" }, -- load Mason first
        lazy=false,
        opts = {
            ensure_installed = {
                "arduino_language_server",
                "bashls",
                "clangd", -- C/C++
                "cmake",
                --"csharp_ls", -- piece of 󰱵
                --"hls", -- Haskell
                "jsonls",
                "lua_ls",
                "ruff_lsp", -- Python
                "rust_analyzer",
            },
            automatic_installation = true,
            handlers = nil -- TODO
        } 
    }
}
