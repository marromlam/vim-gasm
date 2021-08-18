  --[[
nvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general

-- nvim.format_on_save = true
-- nvim.lint_on_save = true

-- keymappings [view all the defaults by pressing <leader>Lk]
-- nvim.leader = "space"
-- add your own keymapping
-- nvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- nvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- nvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Use which-key to add extra bindings with the leader-key prefix
-- nvim.builtin.which_key.mappings["P"] = { "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "Projects" }
-- nvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnosticss" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnosticss" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
-- nvim.builtin.dashboard.active = true
-- jnvim.builtin.terminal.active = true
--- nvim.builtin.nvimtree.side = "left"
-- nvim.builtin.nvimtree.show_icons.git = 1


-- if you don't want all the parsers change this to a table of the ones you want
-- nvim.builtin.treesitter.ensure_installed = "maintained"
-- nvim.builtin.treesitter.ignore_install = { "haskell" }
-- nvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- nvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- set a formatter if you want to override the default lsp one (if it exists)
-- nvim.lang.python.formatters = {
--   {
--     exe = "black",
--     args = {}
--   }
-- }
-- set an additional linter
-- nvim.lang.python.linters = {
--   {
--     exe = "flake8",
--     args = {}
--   }
-- }


-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- nvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
