[GitHub link](https://github.com/hrsh7th/nvim-cmp)
_A completion plugin for neovim coded in Lua._

# Sources

## [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
Neovim's built-in language server client.

Language servers provide different completion results depending on the capabilities of the client. nvim-cmp supports more types of completion candidates than default omnifunc, override the capabilities sent to the server with `require('cmp_nvim_lsp').default_capabilities()`

## [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)
[luasnip](https://github.com/L3MON4D3/LuaSnip) completion source

To disable filtering completion candidates by snippet's show_condition use the following options in sources:
```lua
sources = {
  { name = 'luasnip', option = { use_show_condition = false } },
},
```
To de-/activate autosnippets use `option = { show_autosnippets = true } }`

If you want to just hide some autosnippets consider the hidden option of luaSnip

## [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
Buffer words completion source

Can freely edit the buffer while it is being indexed.
`indexing_batch_size` lines are taken from the buffer scanned, then sleep for `indexing_interval` milliseconds. Decreasing interval and/or increasing the batch size = faster indexing, higher CPU usage and more lag when editing the file while indexing is still in progress.


## []()


# Configuration
1. You must provide a `snippet.expand` function.
2. `cmp.setup.cmdline` won't work if you use the `native` completion menu.
3. You can disable the `default` options by specifying `cmp.config.disable` value.

`cmp.setup()` can be called multiple times

```lua
cmp.setup {
    sources = {
        { name = 'nvim_lsp', group_index = 1 },
        { name = 'buffer', group_index = 2 },
    }
}
```
You can also achieve this by using the built-in configuration helper like this:
```lua
cmp.setup {
    sources = cmp.config.sources(
        { { name = 'nvim_lsp' } }, 
        { { name = 'buffer'   } })
}
```
## My findings
1. `preselect = cmp.PreselectMode.Item` is for LSP preselection, when the LSP server explicitly asks to preselect certain item, and that item is not necessarily the first one in the list.
2. `cmp.setup(c)` = `cmp.setup.global(c)`,
calls `config.set_global(c)`
calls `config.global = config.normalize(misc.merge(c, config.global))`
`config.normalize(c)` repaces each `k` and `v` in `c.mapping` with `keymap.normalize(k)` and `mapping(v, { 'i' })` respectively.

SO, using `mapping = {...}` instead of `cmp.mapping.preset.insert({...})` is legal.

