### \<Cmd\>
Almost the same as `:`, but there are differences:
- No going to normal-mode, commands is executed in the current mode.
- Does not trigger `CmdlineEnter` and `CmdlineLeave` events. This helps performance.
- The command is not echo'ed, no need for `<silent>`.
### :norm\[al]\[!] `{commands}`
Execute **Normal** mode `{commands}` like they were typed. For undo all commands are undone together. Execution stops when an error is encountered.
If `!` is given, mappings won't be used. Without `!` the `{commands}` will be recursive even if `:norm` is called from a `noremap`, i.e.
```VimScript
:map x j
:noremap z :norm x<CR>  " will press j
:noremap z :norm! x<CR> " will press x
```
### getchar(), nr2char() and getcharstr()
**getchar**(`expr`) and **getcharstr**(`expr`)
Get a single character from the user or input stream.
- If `expr` is omitted, wait until a character is available.
- If `expr` is 0, only get a character when one is available. Return zero otherwise.
- If `expr` is 1, only check if a character is available, it is not consumed.  Return zero if no character available.

**getcharstr**(`expr`) = **nr2char**(**getchar**(`expr`))
### \<expr\>
The expression is evaluated to obtain the `{rhs}` that is used.
For abbreviations `v:char` is set to the character that was typed to trigger the abbreviation. You should not either insert or change the `v:char`.
In case you want the mapping to not do anything, you can have the expression evaluate to an empty string.

You can use `getchar()`, it consumes typeahead if there is any. E.g., if you have these mappings:
```
  inoremap <expr> <C-L> nr2char(getchar())
  inoremap <expr> <C-L>x "foo"
```
If you now type `CTRL-L` nothing happens yet, Vim needs the next character to decide what mapping to use.  If you type `'x'` the second mapping is used and `"foo"` is inserted.  If you type any other key the first mapping is used, `getchar()` gets the typed key and returns it.

Here is an example that inserts a list number that increases:
  ```VimScript
	let counter = 0
	inoremap <expr> <C-L> ListItem()
	inoremap <expr> <C-R> ListReset()

	func ListItem()
	  let g:counter += 1
	  return g:counter .. '. '
	endfunc

	func ListReset()
	  let g:counter = 0
	  return ''
	endfunc
  ```

`CTRL-L` inserts the next number, `CTRL-R` resets the count. `CTRL-R` returns an empty string, so that nothing is inserted.

Be very careful about side effects!  The expression is evaluated while obtaining characters, you may very well make the command dysfunctional.
Therefore the following is blocked for `<expr>` mappings:
- Changing the buffer text `textlock`.
- Editing another buffer.
- The `:normal` command.
- Moving the cursor is allowed, but it is restored afterwards.
- If the cmdline is changed, the old text and cursor position are restored.
If you want the mapping to do any of these let the returned characters do that. (Or use a `<Cmd>` mapping instead.)
