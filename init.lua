-- main file


vim.g.start_time = vim.fn.reltime()
vim.g.elite_mode = true
vim.g.os = vim.loop.os_uname().sysname
vim.g.open_command = vim.g.os == 'Darwin' and 'open' or 'xdg-open'
vim.g.dotfiles = vim.env.DOTFILES or vim.fn.expand '~/.dotfiles'
vim.g.luavim_config = vim.g.dotfiles .. '/.config/nvim'
vim.g.mapleader = ' '
vim.g.maplocalleader = ','


-- this is just for developing my own pluggins
-- vim.cmd[[ let &runtimepath.="," . expand("$HOME") . "/Projects/personal/gruvbox.nvim" ]]
-- vim.cmd[[ let &runtimepath.="," . expand("$HOME") . "/Projects/personal/mytheme.nvim" ]]
-- vim.cmd[[ let &runtimepath.="," . expand("$HOME") . "/Projects/personal/afterglow.nvim" ]]
-- vim.cmd[[ let &runtimepath.="," . expand("$HOME") . "/Projects/personal/mytheme2.nvim" ]]


-- source settings and general keymaps
require("luavim.core.settings")


-- load plugins, colorscheme and autocommands
require("luavim.plugins")
require("luavim.colorscheme")
require("luavim.autocommands")


-- TODO: fix this not working under wich-key
vim.api.nvim_set_keymap("n", "<Up>"   , ":resize -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Down>" , ":resize +2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Left>" , ":vertical resize -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Right>", ":vertical resize +2<CR>", { noremap = true, silent = true })


-- vim:foldmethod=marker
