local M = {
    "williamboman/mason-lspconfig.nvim",
    event = "BufReadPre",
    dependencies = { -- load those first
        "mason.nvim",
        {
            "neovim/nvim-lspconfig",
            config = function() require "configs.lspconfig" end
        }
    }
}

M.opts = {
    ensure_installed = {
        "arduino_language_server",
        "bashls",
        "clangd", -- C/C++
        "cmake",
        --"csharp_ls", -- piece of 󰱵
        "hls", -- Haskell
        "jsonls",
        "lua_ls",
        "ruff_lsp", -- Python
        "rust_analyzer",
    },

    handlers = { -- automatic server setup
        function(server_name) -- default handler
            package.loaded.lspconfig[server_name].setup {}
        end
    }
}

M.opts.handlers.lua_ls = function()
    package.loaded.lspconfig.lua_ls.setup {
        settings = {
            Lua = {
                diagnostics = { globals = { "vim" } }
            }
        }
    }
end

return M
