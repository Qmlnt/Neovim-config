require "assets.options"
require "assets.autocmds"
require "assets.utils" -- global functions here

vim.schedule_wrap(require) "assets.mappings"
