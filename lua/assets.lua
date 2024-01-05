local M = {}

---Handle require fails
---@param module_name string
---@param success_callback fun(module: table): any | any
---@param error_callback? fun(error: string): any | any
---@return any
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

M.border = "single" -- :h nvim_open_win
M.border_bleed = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" } -- full-bleed

return M
