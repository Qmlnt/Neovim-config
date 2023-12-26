return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim", "nvim-lspconfig" }, -- load those first
    lazy = false,
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

        handlers = { -- automatic server setup
            function(server_name) -- default handler
                require("lspconfig")[server_name].setup {}
            end,

            ["lua_ls"] = function()
                require("lspconfig").lua_ls.setup {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" }
                            }
                        }
                    }
                }
            end,

        }
    }
}
