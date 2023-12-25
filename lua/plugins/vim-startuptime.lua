return {
    "dstein64/vim-startuptime",
    cmd = "StartupTime", -- lazy-load on a command
    keys = { { "<Leader>us", "<Cmd>StartupTime<CR>" } },
    init = function() vim.g.startuptime_tries = 25 end
}
