[GitHub link](https://github.com/neovim/nvim-lspconfig/)
_[Configs](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md) for the [Nvim LSP client](https://neovim.io/doc/user/lsp.html) (`:help lsp`)._

### Commands
- `:LspInfo` shows the status of active and configured language servers.
- `:LspStart <config_name>` Start the requested server name. Will only successfully start if the command detects a root directory matching the current config. Pass `autostart = false` to your `.setup{}` call for a language server if you would like to launch clients solely with this command. Defaults to all servers matching current buffer filetype.
- `:LspStop <client_id>` Defaults to stopping all buffer clients.
- `:LspRestart <client_id>` Defaults to restarting all buffer clients.

### Quickstart
1. Install a language server, e.g. [pyright](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright)

```shell
npm i -g pyright
```

2. Add the language server setup to your init.lua.

```lua
require'lspconfig'.pyright.setup{}
```

3. Launch Nvim, the language server will attach and provide diagnostics.

```
nvim main.py
```

4. Run `:LspInfo` to see the status or to troubleshoot.
5. See [Suggested configuration](https://github.com/neovim/nvim-lspconfig/blob/master/README.md#Suggested-configuration) to setup common mappings and omnifunc completion.

See [server_configurations.md](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md) (`:help lspconfig-all` from Nvim) for the full list of configs, including installation instructions and additional, optional, customization suggestions for each language server. For servers that are not on your system path (e.g., `jdtls`, `elixirls`), you must manually add `cmd` to the `setup` parameter. Most language servers can be installed in less than a minute.
