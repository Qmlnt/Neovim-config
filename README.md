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

### Structure
- **init.lua** -- Pull _The stuff_ together
- **lua/** -- _The stuff_
    - **assets/** -- Fundamental parts of the config
        - **init.lua** -- Pull fundamental parts together
            - **options.lua**
            - **autocmds.lua**
            - **mappings.lua** -- Deferred loading cuz there is too much '>.<
        - **assets.lua** -- Decorations and stuff that is used everywhere
        - **utils.lua** -- Useful functions and my playground
    - **specs/** -- Plugin specs which are autosourced (and cached!) by Lazy.nvim
    - **setups/** -- Large parts of plugin specs are here, so the main Lazy spec loads faster
- **doc** -- Some notes I thought I would reread, but in the end I'm better off with the documentation
