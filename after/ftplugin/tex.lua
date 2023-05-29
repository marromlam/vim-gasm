vim.bo.syntax = ''
vim.bo.textwidth = 100
vim.opt_local.spell = true

map('n', ';;', '<Cmd>VimtexCompile<CR>', { desc = 'tex: compile' })
