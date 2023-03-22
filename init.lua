-- This is the init.lua file for my neovim config

-- basics {{{1

vim.g.start_time = vim.fn.reltime()
vim.g.elite_mode = true
vim.g.os = vim.loop.os_uname().sysname
vim.g.open_command = vim.g.os == "Darwin" and "open" or "xdg-open"
vim.g.dotfiles = vim.env.DOTFILES or vim.fn.expand("~/.dotfiles")
vim.g.vim_dir = vim.g.dotfiles .. "/.config/nvim"

-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- project directories
vim.g.projects_dir = vim.env.PROJECTS_DIR or vim.fn.expand("~/projects")
vim.g.work_dir = vim.env.PROJECTS_DIR .. "/work"

-- Ensure all autocommands are cleared
vim.api.nvim_create_augroup("vimrc", {})
vim.cmd([[
if has('gui_running')
  let g:has_gui = 1
else
  let g:has_gui = 0
endif
]])

local ok, reload = pcall(require, "plenary.reload")
local RELOAD = ok and reload.reload_module or function(...) return ... end
local function R(name)
  RELOAD(name)
  return require(name)
end

-- }}}

-- Global namespace {{{

local namespace = {
  ui = {
    winbar = { enable = true },
    foldtext = { enable = false },
  },
  -- some vim mappings require a mixture of commandline commands and function calls
  -- this table is place to store lua functions to be called in those mappings
  mappings = { enable = true },
}

-- This table is a globally accessible store to facilitating accessing
-- helper functions and variables throughout my config
_G.vim6 = vim6 or namespace

_G.map = vim.keymap.set

-- }}}

-- Settings {{{
-- Order matters here as globals needs to be instantiated first etc.
R("vim6.globals")
R("vim6.highlights")
R("vim6.ui")
R("vim6.settings")

-- }}}

-- Plugins {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("vim6.plugins", {
  ui = { border = vim6.ui.current.border },
  defaults = { lazy = true },
  change_detection = { notify = false },
  checker = {
    enabled = true,
    concurrency = 30,
    notify = false,
    frequency = 3600, -- check for updates every hour
  },
  performance = {
    rtp = {
      paths = { vim.fn.stdpath("data") .. "/site" },
      -- disabled_plugins = { "netrw", "netrwPlugin" },
    },
  },
  dev = {
    path = vim.g.projects_dir .. "/personal/",
    patterns = { "akinsho" },
    fallback = true,
  },
})

-- map for plugin manager
map("n", "<leader>pl", "<Cmd>Lazy<CR>", { desc = "plugin manager" })
map("n", "<leader>pm", "<Cmd>Mason<CR>", { desc = "server manager" })
-- cfilter plugin allows filtering down an existing quickfix list
vim.cmd.packadd("cfilter")
-- Color Scheme
-- vim6.wrap_err("theme failed to load because", vim.cmd.colorscheme, "horizon")
-- vim6.wrap_err("theme failed to load because", vim.cmd.colorscheme, "gruvbox")
vim6.wrap_err("theme failed to load because", vim.cmd.colorscheme, "base16-gruvbox-dark-hard")

-- }}}

-- old stuff
-- vim.cmd [[
--   vmap <leader>sk ::w !kitty @ --to=tcp:localhost:$KITTY_PORT send-text --match=num:1 --stdin<CR><CR>
--   autocmd TermOpen * setlocal nonumber norelativenumber
--   autocmd TermOpen * setlocal scl=no
--
--   if has('nvim') && executable('nvr')
--     " pip3 install neovim-remote
--     let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
--     let $EDITOR='nvr --nostart --remote-tab-wait +"set bufhidden=delete"'
--   endif
--   nnoremap S :keeppatterns substitute/\s*\%#\s*/\r/e <bar> normal! ==<CR>
--   set path+=**,.,,
-- ]]

-- vim: fdm=marker
