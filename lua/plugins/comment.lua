return {
    "numToStr/Comment.nvim",
    keys = {
        { "gc", mode = { "n", "x" } },
        { "gb", mode = { "n", "x" } },
        { "gp", "yy<Plug>(comment_toggle_linewise_current)p" },
        { "gp", "ygv<Plug>(comment_toggle_blockwise_visual)'>o<CR>p==", mode = "x" },
    },
    opts = {}
}
