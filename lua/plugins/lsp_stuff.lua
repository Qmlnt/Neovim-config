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
        lazy=true,
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
                function (server_name) -- default handler
                    require("lspconfig")[server_name].setup {}
                end,

                ["lua_ls"] = function ()
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
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = { "mason-lspconfig.nvim" },
        lazy = false,
        config = function()
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        end
    }
}
