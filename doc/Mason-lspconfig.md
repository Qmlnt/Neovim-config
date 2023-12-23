[GitHub link](https://github.com/williamboman/mason-lspconfig.nvim)
`mason-lspconfig` bridges [`mason.nvim`](https://github.com/williamboman/mason.nvim) with the [`lspconfig`](https://github.com/neovim/nvim-lspconfig) plugin - making it easier to use both plugins together.

Its main responsibilities are to:
- register a setup hook with `lspconfig` that ensures servers installed with `mason.nvim` are set up with the necessary configuration
- provide extra convenience APIs such as the `:LspInstall` command
- allow you to (i) automatically install, and (ii) automatically set up a predefined list of servers
- translate between `lspconfig` server names and `mason.nvim` package names (e.g. `lua_ls <-> lua-language-server`)

**Note: this plugin uses the `lspconfig` server names in the APIs it exposes - not `mason.nvim` package names**.

### Commands
- `:LspInstall [<server>...]` - installs the provided servers
- `:LspUninstall <server> ...` - uninstalls the provided servers

### Setup
Order must be preserved:
1. `mason.nvim`
2. `mason-lspconfig.nvim`
3. Setup servers via `lspconfig`

```lua
require("mason").setup()
require("mason-lspconfig").setup()

-- After setting up mason-lspconfig you may set up servers via lspconfig
-- require("lspconfig").lua_ls.setup {}
-- require("lspconfig").rust_analyzer.setup {}
-- ...
```

`mason-lspconfig` provides extra, opt-in, functionality that allows you to automatically set up LSP servers installed via `mason.nvim` without having to manually add each server setup to your Neovim configuration. Refer to `:h mason-lspconfig-automatic-server-setup` for more details.

`automatic_installation` = false: Automatically install LSPs set up via lspconfig.