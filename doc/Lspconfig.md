[GitHub link](https://github.com/neovim/nvim-lspconfig/)
_[Configs](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md) for the [Nvim LSP client](https://neovim.io/doc/user/lsp.html) (`:help lsp`)._
_`nvim-lspconfig` is not required to use the builtin `Nvim lsp` client, it is just a convenience layer._


# Commands
- `:LspInfo` shows the status of active and configured language servers.
- `:LspStart <config_name>` Start the requested server name. Will only successfully start if the command detects a root directory matching the current config. Pass `autostart = false` to your `.setup{}` call for a language server if you would like to launch clients solely with this command. Defaults to all servers matching current buffer filetype.
- `:LspStop <client_id>` Defaults to stopping all buffer clients.
- `:LspRestart <client_id>` Defaults to restarting all buffer clients.


# Quickstart
1. Install a language server, e.g. [pyright](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright)
```shell
npm i -g pyright
```
2. Add the language server setup to your init.lua.
```lua
require'lspconfig'.pyright.setup{}
```
3. Launch Nvim, the language server will attach and provide diagnostics.
```shell
nvim main.py
```
4. Run `:LspInfo` to see the status or to troubleshoot.
5. See [Suggested configuration](https://github.com/neovim/nvim-lspconfig/blob/master/README.md#Suggested-configuration) to setup common mappings and omnifunc completion.

See [server_configurations.md](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md) (`:help lspconfig-all` from Nvim) for the full list of configs, including installation instructions and additional, optional, customization suggestions for each language server. For servers that are not on your system path (e.g., `jdtls`, `elixirls`), you must manually add `cmd` to the `setup` parameter. Most language servers can be installed in less than a minute.


# setup() metamethod
Using the default configuration for a server is simple:
```lua
    require'lspconfig'.clangd.setup {}
```
The purpose of `setup()` is to wrap the call to Nvim's built-in `vim.lsp.start_client()` with an autocommand that calls `start_client()` or `vim.lsp.buf_attach_client()` depending on whether the current file belongs to a project with a currently running client.

The `setup()` function takes a table which contains a superset of the keys listed in `:help vim.lsp.start_client()` with the following unique entries:
- root_dir
- name
- filetypes
- autostart
- single_file_support
- on_new_config - Most commonly, this is used to inject additional arguments into `cmd`.

Note: all entries passed to `setup()` override the entry in the default configuration. There is no composition.

The most common overrides are:
- capabilities - Broadcast additional functionality provided by plugins to the server.
- cmd - A list where each entry corresponds to the blankspace delimited part of the command that launches the server.
- handlers - See `:h lsp-handler`.
- init_options - A table passed during the initialization notification after launching a language server.
- on_attach - Callback invoked by Nvim's built-in client when attaching a buffer to a language server.
- settings - Allows a user to change optional runtime settings of the language server.

The global defaults for all servers can be overridden by extending the `default_config` table.


# Root detection
A project's `root_dir` is used by `lspconfig` to determine whether `lspconfig` should start a new server, or attach a previous one, to the current file.

The following utility functions are provided by `lspconfig`. Each function call below returns a function that takes as its argument the current buffer path.
- `util.root_pattern`
- `util.find_git_ancestor`
- `util.find_node_modules_ancestor`
- `util.find_package_json_ancestor`

## Advanced root detection
The `root_dir` key in `config` and `setup` can hold any function of the form

    function custom_root_dir(filename, bufnr)
    returns nil | string

This allows for rich composition of root directory patterns which is necessary for some project structures.

