- <`parameter`> = <`default value`>: <`notes`>
- `backup` and `writebackup` = off; on:
	-
	  ```
	  'backup' 'writebackup'	action	 
	   off	    off		no backup made
	   off	    on		backup current file, deleted afterwards (default)
	   on	     	off		delete old backup, backup current file
	   on	     	on		delete old backup, backup current file
	  ```
- `numberwidth` = 4: num of columns **-1** (the space before text) to use for the line number. If `numberwidth` = 4, and the number is 1000, then 5 columns would be used.
- `smartindent` = off: normally `autoindent`(=on) should be also **on**.
- `shiftwidth` = 8: Number of spaces to use for each step of (auto)indent.  Used for `>>` , `<<`, etc.
- `tabstop` = 8: Number of spaces that a `<Tab>` in the file counts for.
- `expandtab` = off: In Insert mode: Use the appropriate number of spaces to insert a `<Tab>`.
- `softtabstop` = 0(off): Number of spaces that a `<Tab>` counts for while performing editing operations. It "feels" like `<Tab>`s are being inserted, while in fact a mix of spaces and `<Tab>`s is used.
- `title` = off: Better window title – `filename [+=-] (path) - NVIM`
- `updatetime` = 4000: If this many milliseconds nothing is typed the swap file will be.  Also used for the `CursorHold` autocommand event.