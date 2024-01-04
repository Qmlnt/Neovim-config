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

## []()
## []()


# Configuration
1. You must provide a `snippet.expand` function.
2. `cmp.setup.cmdline` won't work if you use the `native` completion menu.
3. You can disable the `default` options by specifying `cmp.config.disable` value.

`cmp.setup()` can be called multiple times

Mappings can be done with:
```vim
<Cmd>lua require('cmp').complete()<CR>
```

It is possible to specify the modes the mapping should be active in (`i` = insert mode, `c` = command mode, `s` = select mode):
```lua
cmp.setup {
    mapping = {
        ['<CR>'] = cmp.mapping(your_mapping_function, { 'i', 'c' })
    }
}
```
Different mappings for different modes:
```lua
cmp.setup {
    mapping = {
        ['<CR>'] = cmp.mapping(your_mapping_function, { 'i', 'c' })
    }
}
```

If you don't want to see `buffer` source items while `nvim-lsp` source is available:
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

