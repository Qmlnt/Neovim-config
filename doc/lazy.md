[GitHub link](https://github.com/folke/lazy.nvim/tree/main)
_Modern plugin manager_.
- Caching and bytecode compilation of Lua modules.
- Lazy-load on events, commands, filetypes, and key mappings.
- Generates help for plugins that don't have vimdocs from their `README.md`.
- Lockfile `lazy-lock.json` to keep track of installed plugins.
- Statusline component to see the number of pending updates.

Some commands:
- `:Lazy check` Check for updates and show the log (git fetch).
- `:Lazy update` Update plugins. This will also update the lockfile.
- `:Lazy clean` Clean plugins that are no longer needed.
- `:Lazy restore` Updates all plugins to the state in the lockfile.
- `:Lazy sync` Run install, clean and update.
- `:Lazy load {plugins}` Load a plugin that has not been loaded yet. Use `:Lazy! load` to skip `cond` checks.
- `:Lazy reload {plugins}` Reload a plugin.

Command with a **bang** waits till it is finished. Sync lazy from the cmdline:

```shell
$ nvim --headless "+Lazy! sync" +qa
```

Plugins will be lazy-loaded when one of the following is `true`:
- The plugin only exists as a dependency in your spec
- It has an `event`, `cmd`, `ft` or `keys` key
- `config.defaults.lazy == true`

Set `mapleader` before lazy for plugin mappings to work correctly
```lua
vim.g.mapleader = " "
require("lazy").setup(plugins, opts)
```
- `opts` is optional, the configuration of Lazy itself.
- `plugins` is a `table`/`string`
	- `table` uses [Plugin Spec](https://github.com/folke/lazy.nvim/blob/main/README.md#-plugin-spec), mainly used ones:
		- **lazy** `false`; When `true` the plugin will only be loaded when needed.
		- **priority** `50`; Only useful for **start** plugins (`lazy=false`), set to a high number (`1000`) for your **main colorscheme** to load **first**, as start plugins can possibly change existing highlight groups.
		- **dependencies** `LazySpec[]`; A list of plugin names or plugin specs that should be loaded when the plugin loads. Dependencies are always lazy-loaded unless specified otherwise. When specifying a name, make sure the plugin spec has been defined somewhere else.
		- **init** `fun(LazyPlugin)`; Always executed during startup. Configuration for VIM plugins typically should be set in an init function.
		- **opts** `table`; Setting this option will call `config(LazyPlugin, opts)`.
		- **config** `fun(LazyPlugin, opts)`/`true`; Executed when plugin loads. The default implementation calls `requrie(MAIN).setup(opts)`. Set to `true` to call `requrie(MAIN).setup({})`, though _`opts={}` is the **preferred** way!_ Don't forget to call `requrie('plugin').setup(opts)` in your own implementation!
		-  **main** `string`; You can specify the `MAIN` module to use for `config()` and `opts()`, in case it can not be determined automatically.
		- **enabled**; When `false`, or if the `function` returns false, then this plugin will not be included in the spec.
		- **build** `fun(LazyPlugin)`/ `string`/list of build cmds; Executed when a plugin is installed or updated. `string` – shell command, `:string` – Neovim command. Some plugins provide their own `build.lua` which is automatically used by lazy.
		- **event**; Lazy-load on event. You can use `VeryLazy` event for things that can load **later** and are not important for the initial UI.
	- `string` is the name of the Lua module.
		- The specs from the **module** and any top-level **sub-modules** (e.g. `module/sub_mod.lua`) will be merged together in the final spec.
		- Benefits:
			- Simple to **add** new plugin specs.
			- Allows for **caching** all of the plugin specs, great for speed.
			- Spec changes will automatically be **reloaded** when they're updated.
		- Example:
			- `~/.config/nvim/init.lua`
			
				```lua
				require("lazy").setup("plugins")
				```
			
			- `~/.config/nvim/lua/plugins.lua` or `~/.config/nvim/lua/plugins/init.lua` **_(this file is optional)_**
			
				```lua
				return {
				  "folke/neodev.nvim",
				  "folke/which-key.nvim",
				  { "folke/neoconf.nvim", cmd = "Neoconf" },
				}
				```
				
			- Any lua file in `~/.config/nvim/lua/plugins/*.lua` will be **automatically** merged in the main plugin spec. For example `.config/nvim/lua/plugins/colorschemes.lua`:
				```lua
				return {
				    {   "folke/tokyonight.nvim",
				        lazy = false,    -- for priority to work
				        priority = 1000, -- load before all other start plugins
				        opts = { style = "night" },
				        config = function(_, opts)
				            require("tokyonight").setup(opts)
				            vim.cmd.colorscheme "tokyonight"
				        end },
				    { "navarasu/onedark.nvim", lazy = true }
				}
			  ```
		- [LazyVim](https://github.com/LazyVim/LazyVim) is an amazing example of this structure.
		- Both of the `setup()` calls are equivalent:
		  ```lua
		require("lazy").setup("plugins")
		require("lazy").setup({{import = "plugins"}})
		```

