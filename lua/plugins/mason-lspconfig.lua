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
        "lua_ls",
        "bashls",
        "rust_analyzer",
        -- "arduino_language_server",
        -- "clangd", -- C/C++
        -- "cmake",
        --"csharp_ls", -- piece of 󰱵
        -- "hls", -- Haskell
        -- "taplo", -- toml
        -- "jsonls",
        -- "ruff_lsp", -- Python
    },

    handlers = {              -- automatic server setup
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

M.opts.handlers.rust_analyzer = function() -- TODO
    package.loaded.lspconfig.rust_analyzer.setup {
        settings = {
            ["rust-analyzer"] = {
                cargo = {
                    allFeatures = true,
                    loadOutDirsFromCheck = true,
                    runBuildScripts = true,
                },
                -- Add clippy lints for Rust.
                checkOnSave = {
                    allFeatures = true,
                    command = "clippy",
                    extraArgs = {
                        "--",
                        "--no-deps",              -- run Clippy only on the given crate
                        -- Deny, Warn, Allow, Forbid
                        "-Wclippy::correctness", -- code that is outright wrong or useless
                        "-Wclippy::complexity",  -- code that does something simple but in a complex way
                        "-Wclippy::suspicious",  -- code that is most likely wrong or useless
                        "-Wclippy::style",       -- code that should be written in a more idiomatic way
                        "-Wclippy::perf",        -- code that can be written to run faster
                        "-Wclippy::pedantic",    -- lints which are rather strict or have occasional false positives
                        "-Wclippy::nursery",     -- new lints that are still under development
                        "-Wclippy::cargo",       -- lints for the cargo manifest
                        -- Use in production
                        "-Aclippy::restriction", -- lints which prevent the use of language and library features
                        -- Other
                        "-Aclippy::must_use_candidate", -- must_use is rather annoing
                    },
                },
                procMacro = {
                    enable = true,
                    -- ignored = {
                    --     ["async-trait"] = { "async_trait" },
                    --     ["napi-derive"] = { "napi" },
                    --     ["async-recursion"] = { "async_recursion" },
                    -- },
                },
            },
        }
    }
end

return M
