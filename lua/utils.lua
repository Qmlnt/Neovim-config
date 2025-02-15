local map = vim.keymap.set

---function() y("1") end = W(y) "1"
---function() y(1,2) end = W(y,1,2)
---@param func function
function W(func, ...)
    if ... then
        local args = {...}
        return function() func(unpack(args)) end
    end
    return function(arg)
        return function() func(arg) end
    end
end

---vim.keymap.set("n","<Leader>t",":Lazy<CR>",{desc="D"}) = Lmap("t", "D", ":Lazy<CR>")
---vim.keymap.set({"n","v"},"<Leader>D",":Lazy<CR>",{desc="D"}) = Lmap("t", "nv", "D", ":Lazy<CR>")
function Lmap(...)
    local args = {...}
    local len = select("#", ...)

    if len == 3 then -- most used
        map("n", "<Leader>"..args[1], args[3], { desc = args[2] })
    elseif len == 2 then
        map("n", "<Leader>"..args[1], args[2])
    else -- 4
        local modes = {}
        args[2]:gsub(".", function(c) table.insert(modes, c) end)
        map(modes, "<Leader>"..args[1], args[4], { desc = args[3] })
    end
end


-- if try() succeeds then else_() else except(), always finally()
function Try(try, except, else_, finally)
    return function()
        if pcall(try) then
            if else_ then else_() end
        else
            if except then except() end
        end
        if finally then finally() end
    end
end


---Switch move pair to tresitter.textobjects.repeatable_move when it becomes available
---@param char string
---@param desc string
---@param next_func function
---@param prev_func function
function MakePair(char, desc, next_func, prev_func)
    local function check_treesitter(func)
        local ts_repeat = package.loaded["nvim-treesitter.textobjects.repeatable_move"]
        if not ts_repeat then return func() end

        local next, prev = ts_repeat.make_repeatable_move_pair(next_func, prev_func)
        map("n", "]"..char, next, { desc = "Next "..desc.." (repeatable)" })
        map("n", "["..char, prev, { desc = "Prev "..desc.." (repeatable)" })
        if func == next_func then next() else prev() end
    end

    map("n", "]"..char, function() check_treesitter(next_func) end, { desc = "Next "..desc })
    map("n", "["..char, function() check_treesitter(prev_func) end, { desc = "Prev "..desc })
end
