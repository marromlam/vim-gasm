-- since most are enabled by default you can turn them off
-- using this table and only enable for a few filetypes
-- vim.g.copilot_filetypes = { ["*"] = false, python = true }

-- imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")
-- vim.g.copilot_no_tab_map = true
-- vim.keymap.set.keymap("i", "<C-a>", ":copilot#Accept('\\<CR>')<CR>", { silent = true })

-- <C-]>                   Dismiss the current suggestion.
-- <Plug>(copilot-dismiss)
--
--                                                 *copilot-i_ALT-]*
-- <M-]>                   Cycle to the next suggestion, if one is available.
-- <Plug>(copilot-next)
--
--                                                 *copilot-i_ALT-[*
-- <M-[>                   Cycle to the previous suggestion.
-- <Plug>(copilot-previous)

vim.g.copilot_node_command = "$HOMEBREW_PREFIX/Cellar/node@16/16.19.1/bin/node"
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
vim.g.copilot_filetypes = {
  ["*"] = true,
  gitcommit = false,
  NeogitCommitMessage = false,
}
core.imap("<c-a>", [[copilot#Accept("\<CR>")]], { expr = true, script = true })

vim.cmd [[highlight CopilotSuggestion guifg=#555555 ctermfg=8]]

-- vim: fdm=marker
