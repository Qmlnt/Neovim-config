## <`parameter`> = <`default value`>: <`notes`>
# behaviour
- `undolevel` = 1000: Maximum number of changes that can be undone.  Since undo information is kept in memory, higher numbers will cause more memory to be used.
- `backup` and `writebackup` = off; on:
    - ```
      'backup' 'writebackup'		action	 
       off	      off	  no backup made
       off	      on	  backup current file, deleted afterwards (default)
       on	      off	  delete old backup, backup current file
       on	      on	  delete old backup, backup current file
      ```
- `updatetime` = 4000: If this many milliseconds nothing is typed the swap file will be.  Also used for the `CursorHold` autocommand event.
- `confirm` = off: confirm writing to a changed buffer on `:q` instead of throwing an **ERROR**.

# movement
- `smartindent` = off: normally `autoindent`(=on) should be also **on**.
- `shiftwidth` = 8: Number of spaces to use for each step of (auto)indent.  Used for `>>` , `<<`, etc.
- `tabstop` = 8: Number of spaces that a `<Tab>` in the file counts for.
- `expandtab` = off: In Insert mode: Use the appropriate number of spaces to insert a `<Tab>`.
- `softtabstop` = 0(off): Number of spaces that a `<Tab>` counts for while performing editing operations. It "feels" like `<Tab>`s are being inserted, while in fact a mix of spaces and `<Tab>`s is used.
- `virtualedit` = ""(none): The cursor can be positioned where there is no actual character.

# look
- `title` = off: Better window title – `filename [+=-] (path) - NVIM`
- `numberwidth` = 4: minimal number of columns **-1** (the space before text) to use for the line number. If `numberwidth` = 4, and the number is 1000, then 5 columns would be used.
- `o.signcolumn` = auto: set to `number` to display signs on the `numbercolumn`.
- `conceallevel` = 0: 0 – normal text; ... 3 – Concealed text (markdown ^.^) is completely hidden.
- `ignorecase` = off and `smartcase` = off: If the `ignorecase` option is on, the case of normal letters is ignored. `smartcase` can be set to ignore case when the pattern contains lowercase letters only. In search use `\c` for **ignorecase** and ignore **smartcase**, and `\C` for case sensitive search.
- `list` = off: Show tabs as "`>`", trailing spaces as "`-`", and non-breakable space characters as "`+`".
- `wildmode` = full: Vim command line completion mode. `longest:full,full` on first `<Tab>` completes the longest common part, on next `<Tab>` cycles through the wildmenu.
- `laststatus` = 2: The value of this option influences when the last window will have a status line: ... 2=always; 3=always, and ONLY on the last window.
- `linebreak` = off: when `wrap=on`, wrap long lines at a character in `breakat`. Only affects the way the file is displayed.
- `showbreak` = "": String to put at the start of wrapped lines.
