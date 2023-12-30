Nvim supports the Language Server Protocol (LSP), which means it acts as a client to LSP servers and includes a Lua framework `vim.lsp` for building enhanced LSP tools.
Starting a LSP client will automatically report diagnostics via `vim.diagnostic`.


# Capabilities
To learn what capabilities are available with a started LSP client:
```vim
    :lua =vim.lsp.get_active_clients()[1].server_capabilities
```
Full list of features provided by default can be found in `lsp-buf`.


# Handlers
LSP request/response handlers are implemented as Lua functions. The `vim.lsp.handlers` table defines default handlers used when creating a new client. Keys are LSP method names:
```vim
:lua print(vim.inspect(vim.tbl_keys(vim.lsp.handlers)))
```
lsp-handlers are functions with special signatures that are designed to handle responses and notifications from LSP servers.
There is `vim.lsp.with()` to configure the behavior of a builtin `lsp-handler`:
```lua
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
```
To configure a handler on a per-server basis, you can use the {`handlers`} key for `vim.lsp.start_client()`, or if using [nvim-lspconfig](plugins/Lspconfig), you can use the {`handlers`} key of `setup()`:
```lua
require('lspconfig').lua_ls.setup {
    handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
    }
}
```

Some handlers do not have an explicitly named handler function (such as `vim.lsp.diagnostic.on_publish_diagnostics()`). To override these, first create a reference to the existing handler:
```lua
local on_references = vim.lsp.handlers["textDocument/references"]
vim.lsp.handlers["textDocument/references"] = vim.lsp.with(
    on_references, { loclist = true } -- Use location list instead of quickfix list
)
```
In summary, the `lsp-handler` will be chosen based on the current `lsp-method`
in the following order:
1. Handler passed to `vim.lsp.buf_request()`, if any.
2. Handler defined in `vim.lsp.start_client()`, if any.
3. Handler defined in `vim.lsp.handlers`, if any.


# Events
- LspAttach
- LspDetach
- LspTokenUpdate
- LspProgressUpdate
- LspRequest

