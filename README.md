_This is **my** attempt at configuring Neovim._

What it should be:
- Practical
- Efficient
- Weird but Pretty?
- Fast and Lazy (_I use it as a manpager_)
- Understandable (_Future me will thank me_)
- Different (_If this is your *personal* config, why does it look like everyone's else?_)

What it shouldn't be:
- Huge
- Confusing
- Spaghetti

**Note**: I use Colemak, so `hjkl;` and `Caps` on qwerty is `hneio` and `Backpace` for me. The mappings can be weird sometimes.

## Structure
- **init.lua** -- Pull _The stuff_ together
- **lua/** -- _The stuff_
    - **assets/** -- Fundamental parts of the config
        - **init.lua** -- Pull fundamental parts together
            - **options.lua**
            - **autocmds.lua**
            - **utils.lua** -- Useful functions which are used throughout the config
            - **mappings.lua** -- Deferred loading cuz there is too much '>.<
        - **assets.lua** -- Decorations and stuff that is used everywhere
        - **playground.lua** -- Useful functions which are... well... not very useful
    - **plugins/** -- Plugin specs which are autosourced (and cached!) by Lazy.nvim
    - **configs/** -- Large parts of plugin specs are here, so the main Lazy spec is sourced faster from **plugins/**
- **doc** -- Some notes I thought I would reread, but in the end I'm better off with the documentation, probably will be removed

---

> _Perfection is achieved, not when there is nothing more to add, but when there is nothing left to take away._

― Antoine de Saint-Exupéry
