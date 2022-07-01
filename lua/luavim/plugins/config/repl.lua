local nvim_set_keymap = vim.api.nvim_set_keymap

nvim_set_keymap("n", "<leader>;r", ":KittyREPLRun<cr>", {})
nvim_set_keymap("x", "<leader>;s", ":KittyREPLSend<cr>", {})
nvim_set_keymap("n", "<leader>;s", ":KittyREPLSend<cr>", {})
nvim_set_keymap("n", "<leader>;c", ":KittyREPLClear<cr>", {})
nvim_set_keymap("n", "<leader>;k", ":KittyREPLKill<cr>", {})
nvim_set_keymap("n", "<leader>;l", ":KittyREPLRunAgain<cr>", {})
-- trigger these automatically on extension
nvim_set_keymap("n", "<leader>;w", ":KittyREPLStart<cr>", {})

-- vim: fdm=marker
