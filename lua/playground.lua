---Handle require calls
---@param module_name string
---@param success_callback fun(module: table): any | any
---@param error_callback? fun(error: string): any | any
function Protected_require(module_name, success_callback, error_callback)
    local status, module = pcall(require, module_name)

    if status then
        if type(success_callback) == "function" then
            return success_callback(module)
        end
        return success_callback
    end

    if type(error_callback) == "function" then
        return error_callback(module)
    end
    return error_callback
end


---vim.keymap.set but one-time-use
---@param mode string | table
---@param lhs string
---@param rhs fun(any) | string
---@param opts? table
function Oneshot_keymap(mode, lhs, rhs, opts)
    local buffer = opts and opts.buffer and { buffer = opts.buffer }

    local function trigger_oneshot()
        vim.keymap.set(mode, lhs, rhs, opts)

        local keys = vim.api.nvim_replace_termcodes(lhs, true, false, true)
        vim.api.nvim_feedkeys(keys, "m", false)

        vim.schedule_wrap(vim.keymap.del)(mode, lhs, buffer) -- run a bit later
    end

    vim.keymap.set(mode, lhs, trigger_oneshot, buffer)
end
