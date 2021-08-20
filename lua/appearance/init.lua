if vim.fn.exists "syntax_on" then
  vim.api.nvim_command "syntax reset"
end

vim.o.background = "dark"
vim.o.termguicolors = true

-- vim.g.colors_name = "assegonia"

if vim.g.colors_style == "lighter" then
  vim.o.background = "light"
end

local util = require "appearance.util"
Config = require "appearance.config"


C = require "appearance.palettes.assegonia"
if vim.g.colorscheme == "material" then
  _C = require "appearance.palettes.material"
  for k,v in pairs(_C) do C[k] = v end
end


local async
async = vim.loop.new_async(vim.schedule_wrap(function()
  local skeletons = {}
  for _, skeleton in ipairs(skeletons) do
    util.initialise(skeleton)
  end

  async:close()
end))

local highlights = require "appearance.highlights"
local Treesitter = require "appearance.tree-sitter"
local markdown = require "appearance.markdown"
local Whichkey = require "appearance.which-key"
local Git = require "appearance.git"
local LSP = require "appearance.lang-server"

local skeletons = {
  highlights,
  Treesitter,
  markdown,
  Whichkey,
  Git,
  LSP,
}

for _, skeleton in ipairs(skeletons) do
  util.initialise(skeleton)
end

async:send()
