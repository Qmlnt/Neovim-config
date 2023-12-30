_Nvim provides a framework for displaying errors or warnings from external
tools, otherwise known as "diagnostics".)_

# severity
    vim.diagnostic.severity.ERROR
    vim.diagnostic.severity.WARN
    vim.diagnostic.severity.INFO
    vim.diagnostic.severity.HINT

Functions that take a severity as an optional parameter (e.g.`vim.diagnostic.get()`) accept one of two forms:

1. Single severity
    vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
2. A table with a "min" or "max" key (or both):
    vim.diagnostic.get(0, { severity = { min = vim.diagnostic.severity.WARN } })

The latter form allows users to specify a range of severities.

# diagnostic-handlers
Diagnostics are shown to the user with `vim.diagnostic.show()`. The display of diagnostics is managed through handlers. A handler is a table with a "show" and (optionally) a "hide" function. The "show" function has the signature

    function(namespace, bufnr, diagnostics, opts)

and is responsible for displaying or otherwise handling the given diagnostics. The "hide" function takes care of "cleaning up" any actions taken by the "show" function and has the signature

    function(namespace, bufnr)

Handlers can be configured with `vim.diagnostic.config()` and added by creating a new key in `vim.diagnostic.handlers` (see `diagnostic-handlers-example`).

# looks
`diagnostic-highlights` should be configured in the colorsceme.

    vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", {fg="#FF0000"})

can be used to change the highlight temporarily.

Signs can be changed too:

    sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=

# config()
Note: `vim.diagnostic.config()` can be called multiple times, overriding the options configured before:

    vim.diagnostic.config({ virtual_text = true })

Configuration options accept one of the following:
- `false`: Disable this feature.
- `true`: Enable this feature, use default settings.
- `table`: Enable this feature with overrides. Use an empty table to use default values.
- `function`: Function with signature (namespace, bufnr) that returns any of the above.

# functions
`setloclist()` is local to the current window. `:lw`
`setqflist()` is `setloclist()` globally. `:cw`

