local present, blankline = pcall(require, "indent_blankline")
if not present then
	return
end


blankline.setup {
  char = "▏", -- or │ ┆ ┊ 
  -- indentLine_enabled = 1,  -- what is this for?
  show_foldtext = false,
  show_current_context = true,
  show_current_context_start = true,
  show_first_indent_level = true,
  show_trailing_blankline_indent = false,
  filetype_exclude = {
    'startify',
    'dashboard',
    'log',
    'fugitive',
    'gitcommit',
    'packer',
    'vimwiki',
    'markdown',
    'json',
    'txt',
    'vista',
    'help',
    'NvimTree',
    'git',
    'TelescopePrompt',
    'undotree',
    'flutterToolsOutline',
    'norg',
    'org',
    'orgagenda',
    '', -- for all buffers without a file type
    "help",
    "terminal",
    "dashboard",
    "packer",
    "lspinfo",
    "TelescopePrompt",
    "TelescopeResults",
  },
  buftype_exclude = {
    'terminal',
    'nofile'
  },
  context_patterns = {
    'class',
    'function',
    'method',
    'block',
    'list_literal',
    'selector',
    '^if',
    '^table',
    'if_statement',
    'while',
    'for',
  }
}


-- vim:foldmethod=marker
