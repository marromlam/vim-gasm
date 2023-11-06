-- bootstrap lazy.nvim, LazyVim and your plugins
--
--
--

if vim.g.vscode then
  return
end

local data = vim.fn.stdpath("data")

if vim.loader then
  vim.loader.enable()
end

vim.g.os = vim.loop.os_uname().sysname
vim.g.open_command = vim.g.os == "Darwin" and "open" or "xdg-open"

vim.g.dotfiles = vim.env.DOTFILES or vim.fn.expand("~/.dotfiles")
vim.g.vim_dir = vim.g.dotfiles .. "/.config/nvim"

vim.g.projects_directory = vim.fn.expand("~/Projects")
vim.g.personal_directory = vim.g.projects_directory .. "/personal"
vim.g.work_directory = vim.g.projects_directory .. "/work"

vim.g.obsidian = vim.fn.expand("~")
  .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents"

-- Leader bindings
vim.g.mapleader = " " -- Remap leader key
vim.g.maplocalleader = "\\" -- Local leader is <Space>
--
--
-- Global namespace
local namespace = {
  ui = {
    winbar = { enable = false },
    statuscolumn = { enable = true },
    statusline = { enable = true },
  },
  -- some vim mappings require a mixture of commandline commands and function calls
  -- this table is place to store lua functions to be called in those mappings
  mappings = { enable = true },
}

-- This table is a globally accessible store to facilitating accessing
-- helper functions and variables throughout my config
_G.mrl = mrl or namespace
_G.map = vim.keymap.set
_G.P = vim.print

-- If opening from inside neovim terminal then do not load other plugins
if vim.env.NVIM then
  return require("lazy").setup({ { "willothy/flatten.nvim", config = true } })
end

require("mrl.globals")
-- require("mrl.highlights")
require("mrl.settings")
require("mrl.ui")
require("config.lazy")
-- require("mrl.settings")
vim.cmd([[set nonu nornu]])

vim.cmd.packadd("cfilter")

function mrl.get_hi(name, id)
  id = id or 0
  local hi = vim.api.nvim_get_hl(0, { name = name })
  return hi
end

vim.api.nvim_create_user_command("Format", function()
  -- check if null-ls exists
  local check, nullls = pcall(require, "null-ls")
  -- check if a formatting source of null-ls is registered
  --  wait 2 sec to get the server started
  vim.wait(2000, function()
    return check
      and nullls.is_registered({ method = nullls.methods.FORMATTING })
  end, 1)

  if check and nullls.is_registered({ method = nullls.methods.FORMATTING }) then
    vim.lsp.buf.format()
  else
    vim.cmd([[normal gg=G<C-o>]])
  end
end, {})

vim.keymap.set(
  { "n" },
  "<leader>lf",
  "<cmd>Format<CR>",
  { silent = true, desc = "lsp-format current buffer" }
)

vim.keymap.set(
  { "n" },
  "<leader>tl",
  '<cmd>:exec &nu==&rnu? "se nu!" : "se rnu!"<CR>',
  { silent = true, desc = "toggle line number" }
)

--sdfsdf
vim.api.nvim_set_hl(0, "LineNr", {
  fg = mrl.get_hi("Comment").fg,
  bg = mrl.get_hi("Normal").bg,
})
vim.api.nvim_set_hl(0, "LineNrAbove", {
  fg = mrl.get_hi("Comment").fg,
  bg = mrl.get_hi("Normal").bg,
})
vim.api.nvim_set_hl(0, "NotifyBackground", {
  fg = mrl.get_hi("Comment").fg,
  bg = mrl.get_hi("Normal").bg,
})
vim.api.nvim_set_hl(0, "LineNrBelow", {
  fg = mrl.get_hi("Comment").fg,
  bg = mrl.get_hi("Normal").bg,
})

vim.api.nvim_set_hl(0, "GitSignsAdd", {
  fg = mrl.get_hi("GitSignsAdd").fg,
  -- bg = mrl.get_hi("Normal").bg,
})
vim.api.nvim_set_hl(0, "GitSignsChange", {
  fg = mrl.get_hi("GitSignsChange").fg,
  -- bg = mrl.get_hi("Normal").bg,
})
vim.api.nvim_set_hl(0, "GitSignsDelete", {
  fg = mrl.get_hi("GitSignsDelete").fg,
  -- bg = mrl.get_hi("Normal").bg,
})
vim.api.nvim_set_hl(0, "GitSignsUntracked", {
  fg = mrl.get_hi("GitSignsUntracked").fg,
  -- bg = mrl.get_hi("Normal").bg,
})

vim.api.nvim_set_hl(0, "Statusline", {
  fg = mrl.get_hi("StatusLine").fg,
  bg = mrl.get_hi("Normal").bg,
})

vim.api.nvim_set_hl(0, "StatuslineGitSignsAdd", {
  fg = mrl.get_hi("GitSignsAdd").fg,
  -- other stuff
  -- other stuff
  bg = mrl.get_hi("StatusLine").bg,
})

vim.api.nvim_set_hl(0, "StatuslineGitSignsDelete", {
  fg = mrl.get_hi("GitSignsDelete").fg,
  bg = mrl.get_hi("StatusLine").bg,
})

vim.api.nvim_set_hl(0, "StatuslineSearch", {
  fg = mrl.get_hi("Search").fg,
  bg = mrl.get_hi("Search").bg,
})

vim.api.nvim_set_hl(0, "StatuslineBranch", {
  fg = mrl.get_hi("Search").bg,
  bg = mrl.get_hi("StatusLine").bg,
})

vim.api.nvim_set_hl(0, "StatuslineRed", {
  fg = mrl.get_hi("GitSignsDelete").fg,
  bg = mrl.get_hi("StatusLine").bg,
})
vim.api.nvim_set_hl(0, "StatuslineParentDirectory", {
  fg = mrl.get_hi("IncSearch").bg,
  bg = mrl.get_hi("StatusLine").bg,
  bold = true,
})
vim.api.nvim_set_hl(0, "StatuslineEnv", {
  fg = mrl.get_hi("Error").bg,
  bg = mrl.get_hi("StatusLine").bg,
  bold = true,
  italic = true,
})
vim.api.nvim_set_hl(0, "StatuslineDirectory", {
  fg = mrl.get_hi("Comment").fg,
  bg = mrl.get_hi("Statusline").bg,
  bold = false,
  italic = true,
})
vim.api.nvim_set_hl(0, "StatuslineDirectoryInactive", {
  fg = mrl.get_hi("Comment").fg,
  bg = mrl.get_hi("Statusline").bg,
  bold = false,
  italic = false,
})
vim.api.nvim_set_hl(0, "StatuslineFilename", {
  fg = mrl.get_hi("Normal").fg,
  bg = mrl.get_hi("Statusline").bg,
  bold = true,
  italic = false,
})
vim.api.nvim_set_hl(0, "WinSeparator", {
  fg = mrl.get_hi("Statusline").fg,
  bg = mrl.get_hi("Normal").bg,
  bold = false,
})
-- vim: fdm=marker
