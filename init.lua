-- main file

vim.g.start_time = vim.fn.reltime()
vim.g.elite_mode = true
vim.g.os = vim.loop.os_uname().sysname
vim.g.open_command = vim.g.os == "Darwin" and "open" or "xdg-open"
vim.g.dotfiles = vim.fn.expand "~/.dotfiles"
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.cmd [[
if has('gui_running')
  let g:has_gui = 1
else
  let g:has_gui = 0
endif
]]

-- source settings and general keymaps
require "luavim.core"

-- load plugins, colorscheme and autocommands
require "luavim.plugins"
require "luavim.colorscheme"
require "luavim.autocommands"


-- vim.cmd [[
--   augroup LspFormat
--     autocmd! * <buffer>
--     " autocmd BufWritePre <buffer> lua require("config.lsp.null-ls.formatters").format()
--     autocmd BufWritePre <buffer> Format
--   augroup END
-- ]]


vim.cmd [[
  vmap <leader>sk ::w !kitty @ --to=tcp:localhost:$KITTY_PORT send-text --match=num:1 --stdin<CR><CR> 
  autocmd TermOpen * setlocal nonumber norelativenumber
  autocmd TermOpen * setlocal scl=no

  if has('nvim') && executable('nvr')
    " pip3 install neovim-remote
    let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
    let $EDITOR='nvr --nostart --remote-tab-wait +"set bufhidden=delete"'
  endif
  nnoremap S :keeppatterns substitute/\s*\%#\s*/\r/e <bar> normal! ==<CR>
  set path+=**,.,,
]]

-- vim: fdm=marker
