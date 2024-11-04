_This is **my** configuration of Neovim._

It is:
- Understandable (_kinda_)
- Fast and Lazy (_Good as a manpager_)
- Pleasant to read and edit (for me 😒)
- Different (_If this is your *personal* config, why does it look like everyone's else?_)

It is **not**:
- A whole IDE enviroment
- A privacy nightmare

**Note**: I use Colemak. The mappings can be weird sometimes.

## Structure
- **init.lua**: Pull _The stuff_ together
- **lua/**: _The stuff_
    - **utils.lua**: Useful functions used throughout the config
    - **options.lua**
    - **autocmds.lua**
    - **mappings.lua**: Deferred loading cuz there is too much '>.<
    - **plugins/**: Plugin specs which are autosourced (and cached!) by Lazy.nvim
    - **configs/**: Large parts of plugin specs separated for faster sourcing of **plugins/**
- **doc**: Don't remember what is there, and Neovim has `:h <whatever>` anyways

**lua/playground.lua**: Useful functions which are... well... not very useful

---

> _Perfection is achieved, not when there is nothing more to add, but when there is nothing left to take away._

― Antoine de Saint-Exupéry
