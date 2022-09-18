local present_gruvbox, gruvbox = pcall(require, "gruvbox")
if present_gruvbox then
  require("gruvbox").setup {
    undercurl = true,
    underline = true,
    bold = true,
    italic = true, -- will make italic comments and special strings
    inverse = true, -- invert background for search, diffs, statuslines and errors
    invert_selection = true,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    contrast = "hard", -- can be "hard" or "soft"
    overrides = {},
  }
end

vim.cmd [[
try
  colorscheme gruvbox
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
