[GitHub link](https://github.com/nvim-treesitter/nvim-treesitter)
_An incremental parsing system for programming tools. Provides syntax highlighting and code actions._

Nvim-treesitter is based on three interlocking features: **language parsers**, **queries**, and **modules**, where `modules` provide features – e.g., highlighting – based on `queries` for syntax objects extracted from a given buffer by `language parsers`.
### Commands
- `:TSUpdate` – update all parsers to the latest version, **make sure to call this when upgrading the plugin**.
- `:TSInstall language_to_install>`, _supports tab expansion_.
- `:TSInstallInfo` – list all available languages and their installation status.
- `:TSModuleInfo` – list modules state. (_highlight, incremental\_selection, indent_).
- `TS(Buf)Enable`/`TS(Buf)Disable` – enable/disable module (on buffer), can take a filetype additionally.
### Configuration
Each module provides a distinct tree-sitter-based feature such as **highlighting**, **indentation**, or **folding**. _All modules are disabled by default and need to be activated explicitly in your configuration_.
- `auto_install` – install missing parsers when **entering** a buffer. With [[lazy]]'s `event = "VeryLazy"` upon entering Neovim with `nvim file` use `:e` to reload the buffer for auto installation to start. Also `tree-sitter-cli` needs to be installed locally.