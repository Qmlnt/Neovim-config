local M = {}


---function() y("1") end = with(y) "1"
---function() y(1,2) end = with(y,1,2)
---@param func fun(...)
function M.with(func, ...)
    if ... then
        local args = {...}
        return function() func(unpack(args)) end
    end
    return function(arg)
        return function() func(arg) end
    end
end

local map = vim.keymap.set -- no table lookups
---vim.keymap.set("n","<Leader>t",":Lazy<CR>",{desc="D"}) = Lmap("t", "D", ":Lazy<CR>")
---vim.keymap.set({"n","v"},"<Leader>D",":Lazy<CR>",{desc="D"}) = Lmap("t", "nv", "D", ":Lazy<CR>")
function M.Lmap(...)
    local args = {...}

    if #args == 3 then -- most used
        map("n", "<Leader>"..args[1], args[3], { desc = args[2] })
    elseif #args == 2 then
        map("n", "<Leader>"..args[1], args[2])
    else -- 4
        local modes = {}
        args[2]:gsub(".", function(c) table.insert(modes, c) end)
        map(modes, "<Leader>"..args[1], args[4], { desc = args[3] })
    end
end


---Handle require calls
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


---vim.keymap.set but one-time-use
---@param mode string | table
---@param lhs string
---@param rhs fun(any) | string
---@param opts? table
function M.oneshot_keymap(mode, lhs, rhs, opts)
    local buffer = opts and opts.buffer and { buffer = opts.buffer }

    local function trigger_oneshot()
        vim.keymap.set(mode, lhs, rhs, opts)

        local keys = vim.api.nvim_replace_termcodes(lhs, true, false, true)
        vim.api.nvim_feedkeys(keys, "m", false)

        vim.schedule_wrap(vim.keymap.del)(mode, lhs, buffer) -- run a bit later
    end

    vim.keymap.set(mode, lhs, trigger_oneshot, buffer)
end


return M
