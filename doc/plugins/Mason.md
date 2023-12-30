[GitHub link](https://github.com/williamboman/mason.nvim)
_Portable package manager for Neovim that runs everywhere Neovim runs.
Easily install and manage LSP servers, DAP servers, linters, and formatters._

Packages are installed in Neovim's data directory ([`:h standard-path`](https://neovim.io/doc/user/starting.html#standard-path)) by default. Executables are linked to a single `bin/` directory, which `mason.nvim` will add to Neovim's PATH during setup, allowing seamless access from Neovim builtins (shell, terminal, etc.) as well as other 3rd party plugins.

### Commands
- `:Mason` - opens a graphical status window
	- **g?** to stop it. Get some help.
- `:MasonUpdate` - updates all managed registries
- `:MasonInstall <package> ...` - installs/re-installs the provided packages
- `:MasonUninstall <package> ...` - uninstalls the provided packages
- `:MasonUninstallAll` - uninstalls all packages
- `:MasonLog` - opens the `mason.nvim` log file in a new tab window

### Plugins to use
Although many packages are perfectly usable out of the box through Neovim builtins, it is recommended to use other 3rd party plugins to further integrate these. The following plugins are recommended:
- LSP: [`lspconfig`](https://github.com/neovim/nvim-lspconfig) & [`mason-lspconfig.nvim`](https://github.com/williamboman/mason-lspconfig.nvim)
- DAP: [`nvim-dap`](https://github.com/mfussenegger/nvim-dap) & [`nvim-dap-ui`](https://github.com/rcarriga/nvim-dap-ui)
- Linters: [`null-ls.nvim`](https://github.com/jose-elias-alvarez/null-ls.nvim) or [`nvim-lint`](https://github.com/mfussenegger/nvim-lint)
- Formatters: [`null-ls.nvim`](https://github.com/jose-elias-alvarez/null-ls.nvim) or [`formatter.nvim`](https://github.com/mhartington/formatter.nvim)

### Requirements
For Unix systems:
- `git(1)`
- `curl(1)` or `wget(1)`
- `unzip(1)`
- GNU tar (`tar(1)` or `gtar(1)` depending on platform)
- `gzip(1)`

Note that `mason.nvim` will regularly shell out to external package managers, such as `cargo` and `npm`. Depending on your personal usage, some of these will also need to be installed. Refer to `:checkhealth mason` for a full list.

### Setup
**`mason.nvim` is optimized to load as little as possible during setup. Lazy-loading the plugin, or somehow deferring the setup, is not recommended.**