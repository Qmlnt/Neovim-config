[GitHub link](https://github.com/nvim-treesitter/nvim-treesitter)
_An incremental parsing system for programming tools. Provides syntax highlighting and code actions._

Nvim-treesitter is based on three interlocking features: **language parsers**, **queries**, and **modules**, where `modules` provide features – e.g., highlighting – based on `queries` for syntax objects extracted from a given buffer by `language parsers`.

For `nvim-treesitter` to support a specific feature for a specific language requires both a **parser** for that language and an appropriate language-specific **query file** for that feature.

### Commands
- `:TSUpdate` – update all parsers to the latest version, **make sure to call this when upgrading the plugin**.
- `:TSInstall language_to_install>`, _supports tab expansion_.
- `:TSInstallInfo` – list all available languages and their installation status.
- `:TSModuleInfo` – list modules state. (_highlight, incremental\_selection, indent_).
- `TS(Buf)Enable`/`TS(Buf)Disable` – enable/disable module (in buffer), can take a filetype additionally.
- `:TSConfigInfo` – get a config table.

### Configuration
Each module provides a distinct tree-sitter-based feature such as **highlighting**, **indentation**, or **folding**. _All modules are disabled by default and need to be activated explicitly in your configuration_.
- `auto_install` = `true` – install missing parsers when **entering** a buffer. With [[Lazy]]'s `event = "VeryLazy"`, upon entering Neovim with `nvim file`, use `:e` to reload the buffer for auto installation to start. Also `tree-sitter-cli` needs to be installed locally.
- `sync_install` = `false` – install parsers asynchronously (only for `ensure_installed`).
- `ignore_install` = `{'parser1', 'p2', 'p3'}` – do not (auto)install.
- `highlight.disable`, can take a `function(lang, buf)` which can return `true` to disable highlighting.
- 