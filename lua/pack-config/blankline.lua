local M = {}

M.config = function()
  local test, blankline = pcall(require, "indent_blankline")

  if not test then
     return
  end

  vim.g.indentLine_enabled = 1
  vim.g.indent_blankline_char = "▏"
  
  vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard", "packer" }
  vim.g.indent_blankline_buftype_exclude = { "terminal" }
  
  vim.g.indent_blankline_show_trailing_blankline_indent = false
  vim.g.indent_blankline_show_first_indent_level = false
  
  vim.cmd [[highlight IndentBlanklineIndent1 guifg=#264F78 blend=nocombine]]
  vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B blend=nocombine]]
  
  blankline.setup {
    space_char_blankline = " ",
    char_highlight_list = {
       "IndentBlanklineIndent1",
       "IndentBlanklineIndent2",
   },
  }
end

return M
