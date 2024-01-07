local M = {}

---Handle require fails
---@param module_name string
---@param success_callback fun(module: table): any | any
---@param error_callback? fun(error: string): any | any
function M.protected_require(module_name, success_callback, error_callback)
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

---Remove lua function mapping after it was triggered
---@param mode string|table
---@param keys string
---@param func fun(any)
---@param buffer? integer
function M.oneshot_lua_keymap(mode, keys, func, buffer)
    local function call_and_dell()
        func()
        vim.keymap.del(mode, keys, buffer and { buffer = buffer })
    end

    vim.keymap.set(mode, keys, call_and_dell, buffer and { buffer = buffer })
end

---vim.keymap.set but one-time-use
---@param mode string|table
---@param lhs string
---@param rhs fun(any)|string
---@param opts? table
function M.oneshot_keymap(mode, lhs, rhs, opts)
    local buffer = opts and opts.buffer and { buffer = opts.buffer }

    local function trigger_oneshot()
        vim.keymap.set(mode, lhs, rhs, opts)

        local keys = vim.api.nvim_replace_termcodes(lhs, true, false, true)
        vim.api.nvim_feedkeys(keys, "m", false) -- TODO check the x option

        vim.schedule(function() -- run a bit later
            vim.keymap.del(mode, lhs, buffer)
        end)
    end

    vim.keymap.set(mode, lhs, trigger_oneshot, buffer)
end

function M.tests()
    vim.keymap.set("n", "z", function() print "hi" end)
    vim.api.nvim_feedkeys("z", "m", false)
    vim.print("bye")
    print("1")
    print("1")
    print("1")
    print("1")
    print("end")
    vim.schedule(function() print("last?") end)
end

M.border = "single" -- :h nvim_open_win
M.border_bleed = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" } -- full-bleed

return M
