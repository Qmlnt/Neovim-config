[GitHub link](https://github.com/williamboman/mason-lspconfig.nvim)
_`mason-lspconfig` bridges [`mason.nvim`](https://github.com/williamboman/mason.nvim) with the [`lspconfig`](https://github.com/neovim/nvim-lspconfig) plugin - making it easier to use both plugins together._

Its main responsibilities are to:
- register a setup hook with `lspconfig` that ensures servers installed with `mason.nvim` are set up with the necessary configuration
- provide extra convenience APIs such as the `:LspInstall` command
- allow you to (i) automatically install, and (ii) automatically set up a predefined list of servers
- translate between `lspconfig` server names and `mason.nvim` package names (e.g. `lua_ls <-> lua-language-server`)

## Commands
- `:LspInstall [<server>...]` - Like `:MasonInstall`, but installs only LSPs and requires `lspconfig` server names
	- `:LspInstall` will prompt you with a selection of servers based on the filetype
	- `LspInstall typescript` will also give a prompt with all LSPs for the language
- `:LspUninstall <server> ...` - uninstalls the provided servers

## Setup
- **Note: this plugin uses the `lspconfig` server names in the APIs it exposes - not `mason.nvim` package names**.
- Note that `lspconfig` needs to be available in `rtp` by the time you set up `mason-lspconfig`
- Make sure to set up `mason` and `mason-lspconfig.nvim` before setting up servers via `lspconfig`

#### Order:
1. `mason.nvim`, load`lspconfig` in `rtp`
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

#### Automatic server setup
`mason-lspconfig` can automatically set up LSPs installed via `mason.nvim`. It also makes it possible to use newly installed servers without having to restart Neovim!
```lua
require("mason-lspconfig").setup({
	handlers = {
		-- The first entry (without a key) will be the default handler
		-- and will be called for each installed server that doesn't have
		-- a dedicated handler.
		function (server_name) -- default handler (optional)
			require("lspconfig")[server_name].setup {}
		end,
		-- Next, you can provide a dedicated handler for specific servers.
		-- For example, a handler override for the `rust_analyzer`:
		["rust_analyzer"] = function ()
			require("rust-tools").setup {}
		end
	}
})
```
**If you use this approach, make sure you don't also manually set up servers directly via `lspconfig` as this will cause servers to be set up more than once.**

You may achieve similar behavior by manually looping through the installed servers with `mason-lspconfig.get_installed_servers()` and setting each one up.
