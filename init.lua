-- Basic {{{
if vim.g.vscode then return end

local g, fn, opt, loop, env, cmd =
  vim.g, vim.fn, vim.opt, vim.loop, vim.env, vim.cmd
local data = fn.stdpath('data')

-- g.start_time = fn.reltime()
g.elite_mode = true
g.os = loop.os_uname().sysname
g.open_command = g.os == 'Darwin' and 'open' or 'xdg-open'
g.dotfiles = env.DOTFILES or fn.expand('~/.dotfiles')
g.vim_dir = g.dotfiles .. '/.config/nvim'
g.projects_dir = env.PROJECTS_DIR or fn.expand('~/projects')
g.work_dir = g.projects_dir .. '/work'
g.personal_dir = g.projects_dir .. '/personal'

-- Leader bindings
g.mapleader = ' ' -- Remap leader key
g.maplocalleader = ',' -- Local leader is <Space>

if vim.loader then vim.loader.enable() end

cmd([[
if has('gui_running')
  let g:has_gui = 1
else
  let g:has_gui = 0
endif
]])

-- }}}

-- Global namespace {{{
local namespace = {
  ui = {
    winbar = { enable = true },
    statuscolumn = { enable = true },
    statusline = { enable = true },
  },
  -- some vim mappings require a mixture of commandline commands and function calls
  -- this table is place to store lua functions to be called in those mappings
  mappings = { enable = true },
}

-- This table is a globally accessible store to facilitating accessing
-- helper functions and variables throughout my config
_G.pde = pde or namespace
_G.map = vim.keymap.set
_G.P = vim.print

-- }}}

-- Settings {{{
-- Order matters here pde globals needs to be instantiated first etc.

require('pde.globals')
require('pde.highlights')
require('pde.ui')
require('pde.settings')

-- }}}

-- Plugins {{{

local lazypath = data .. '/lazy/lazy.nvim'
if not loop.fs_stat(lazypath) then
  fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
  vim.notify('Installed lazy.nvim')
end
opt.runtimepath:prepend(lazypath)

--  $NVIM
-- NOTE: this must happen after the lazy path is setup
-- If opening from inside neovim terminal then do not load other plugins
if env.NVIM then
  return require('lazy').setup({ { 'willothy/flatten.nvim', config = true } })
end

require('lazy').setup('pde.plugins', {
  ui = { border = pde.ui.current.border },
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
      paths = { data .. '/site' },
      disabled_plugins = {
        -- 'netrw',
        -- 'netrwPlugin'
      },
    },
  },
  dev = {
    path = g.personal_dir,
    patterns = { 'marcos' },
    fallback = true,
  },
})

-- }}}

-- Maps {{{

map('n', '<leader>pp', '<Cmd>Lazy<CR>', { desc = 'plugins' })
map('n', '<leader>pm', '<Cmd>Mason<CR>', { desc = 'mason' })
map('n', '<leader>o', '<Cmd>:only<CR>', { desc = 'this only buffer' })

-- closing buffers
map('n', '<leader>x', '<Cmd>:bd<CR>', { desc = 'delete buffer' })
map('n', '<leader>X', '<Cmd>:bd!<CR>', { desc = 'force delete buffer' })
-- ["x"] = { "<cmd>bdelete<CR>", "Close Buffer" },
-- ["X"] = { "<cmd>bdelete!<CR>", "Close Buffer" },
-- ["x"] = { "<cmd>BufferClose<CR>", "Close Buffer" },
-- ["X"] = { "<cmd>BufferCloseAllButCurrent<CR>", "Close Buffer" },
map('n', '<leader>z', '<cmd>%bdelete<CR>', { desc = 'Close All Buffers' })
map('n', '<leader>Z', '<cmd>%bdelete!<CR>', { desc = 'Close All Buffers' })
map('n', '<leader>w', ':w<CR>', { desc = 'Save' })
map('n', '<leader>q', ':q<CR>', { desc = 'Quit' })
map('n', '<leader>W', '<cmd>w!<CR>', { desc = 'Save' })
map('n', '<leader>Q', '<cmd>q!<CR>', { desc = 'Quit' })

map('n', '<Up>', ':resize -2<CR>', { desc = 'resize window up' })
map('n', '<Down>', ':resize +2<CR>', { desc = 'resize window down' })
map('n', '<Left>', ':vertical resize -2<CR>', { desc = 'resize window left' })
map('n', '<Right>', ':vertical resize +2<CR>', { desc = 'resize window right' })
map('n', '<C-q>', ':call ToggleQFList()<CR>', { desc = 'toggle quickfix list' })

-- Stay in indent mode
map('v', '<', '<gv', { desc = 'indent left' })
map('v', '>', '>gv', { desc = 'indent right' })
map('v', 'p', '"_dP', { desc = 'paste without overwriting clipboard' })

-- Custom mappings {{{

-- wk.register({'i'}, 'ax', '<cmd>Htop<cr>', "oladf")
-- Move current line / block with Alt-j/k ala vscode.
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { desc = 'move lines' })
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { desc = 'move lines' })
map('i', '<A-Up>', '<C-\\><C-N><C-w>k', { desc = 'move lines' })
map('i', '<A-Down>', '<C-\\><C-N><C-w>j', { desc = 'move lines' })
map('i', '<A-Left>', '<C-\\><C-N><C-w>h', { desc = 'move lines' })
map('i', '<A-Right>', '<C-\\><C-N><C-w>l', { desc = 'move lines' })

-- navigate tab completion with <c-j> and <c-k> runs conditionally
map(
  'i',
  '<C-j>',
  'pumvisible() ? "\\<C-n>" : "\\<C-j>"',
  { desc = 'tab next completion' }
)
map(
  'i',
  '<C-k>',
  'pumvisible() ? "\\<C-p>" : "\\<C-k>"',
  { desc = 'tab prev completion' }
)

-- if vim.g.elite_mode then
--   -- Resize with arrows
--   wk.register({
--     ["<Up>"]    = { ":resize -2<CR>" },
--     ["<Down>"]  = { ":resize +2<CR>" },
--     ["<Left>"]  = { ":vertical resize -2<CR>" },
--     ["<Right>"] = { ":vertical resize +2<CR>" },
--     },
--     { mode = 'n', silent = true, nowait = true }
--   )
-- else
--   wk.register({
--     ["<leader>e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
--     },
--     { mode = 'n', buffer = nil, silent = true, noremap = true, nowait = true }
--   )
--
-- end

vim.api.nvim_set_keymap(
  'n',
  ']q',
  ':cnext<CR>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  'n',
  '[q',
  ':cprev<CR>',
  { noremap = true, silent = true }
)

-- map("n", "<Tab>", ':BufferLineCycleNext<CR>', {desc='Go to next buffer' })
-- map("n", "<S-Tab>", ':BufferLineCyclePrev<CR>', {desc='Go to previous buffer' })
map('n', '<Tab>', ':bnext<CR>', { desc = 'Go to next buffer' })
map('n', '<S-Tab>', ':bprevious<CR>', { desc = 'Go to previous buffer' })
map('n', '<A-j>', ':move .+1<CR>==', { desc = 'Move line down' })
map('n', '<A-k>', ':move .-2<CR>==', { desc = 'Move line down' })
map('n', ']q', ':cnext<CR>', { desc = 'Next Quickfix element' })
map('n', '[q', ':cnext<CR>', { desc = 'Previous Quickfix element' })
map('n', '<C-q>', ':call QuickFixToggle()<CR>', { desc = 'Toggle Quickfix' })

-- switching buffers
map(
  'n',
  '<leader>1',
  '<cmd>BufferLineGoToBuffer 1<cr>',
  { desc = 'Go to buffer 1' }
)
map(
  'n',
  '<leader>2',
  '<cmd>BufferLineGoToBuffer 2<cr>',
  { desc = 'Go to buffer 2' }
)
map(
  'n',
  '<leader>3',
  '<cmd>BufferLineGoToBuffer 3<cr>',
  { desc = 'Go to buffer 3' }
)
map(
  'n',
  '<leader>4',
  '<cmd>BufferLineGoToBuffer 4<cr>',
  { desc = 'Go to buffer 4' }
)
map(
  'n',
  '<leader>5',
  '<cmd>BufferLineGoToBuffer 5<cr>',
  { desc = 'Go to buffer 5' }
)
map(
  'n',
  '<leader>6',
  '<cmd>BufferLineGoToBuffer 6<cr>',
  { desc = 'Go to buffer 6' }
)
map(
  'n',
  '<leader>7',
  '<cmd>BufferLineGoToBuffer 7<cr>',
  { desc = 'Go to buffer 7' }
)
map(
  'n',
  '<leader>8',
  '<cmd>BufferLineGoToBuffer 8<cr>',
  { desc = 'Go to buffer 8' }
)
map(
  'n',
  '<leader>9',
  '<cmd>BufferLineGoToBuffer 9<cr>',
  { desc = 'Go to buffer 9' }
)
map(
  'n',
  '<leader>0',
  '<cmd>BufferLineGoToBuffer 10<cr>',
  { desc = 'Go to buffer 10' }
)

-- yank to system keyboard
map('n', '<leader>y', '<cmd>OSCYank<CR>', { desc = 'Yank using osc52' })

-- creating splits
map('n', '<leader>|', '<cmd>vsp<CR>', { desc = 'Create vertical split' })
map('n', '<leader>-', '<cmd>sp<CR>', { desc = 'Create horizontal split' })

-- }}}

map('n', '<leader>ph', '<cmd>nohlsearch<CR>', { desc = 'hide highlight' })
--   g = {
--     name = 'Git',
--     g = { '<cmd>lua _LAZYGIT_TOGGLE()<CR>', 'Lazygit' },
--     j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", 'Next Hunk' },
--     k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", 'Prev Hunk' },
--     l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", 'Blame' },
--     p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", 'Preview Hunk' },
--     r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", 'Reset Hunk' },
--     R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", 'Reset Buffer' },
--     s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", 'Stage Hunk' },
--     u = {
--       "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
--       'Undo Stage Hunk',
--     },
--     o = { '<cmd>Telescope git_status<cr>', 'Open changed file' },
--     b = { '<cmd>Telescope git_branches<cr>', 'Checkout branch' },
--     c = { '<cmd>Telescope git_commits<cr>', 'Checkout commit' },
--     d = {
--       '<cmd>Gitsigns diffthis HEAD<cr>',
--       'Diff',
--     },
--   },
--
--   l = {
--     name = 'LSP',
--     a = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code Action' },
--     d = {
--       '<cmd>Telescope lsp_document_diagnostics<cr>',
--       'Document Diagnostics',
--     },
--     w = {
--       '<cmd>Telescope lsp_workspace_diagnostics<cr>',
--       'Workspace Diagnostics',
--     },
--     f = { '<cmd>lua vim.lsp.buf.formatting()<cr>', 'Format' },
--     i = { '<cmd>LspInfo<cr>', 'Info' },
--     I = { '<cmd>LspInstallInfo<cr>', 'Installer Info' },
--     j = {
--       '<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>',
--       'Next Diagnostic',
--     },
--     k = {
--       "<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = 'single'}})<cr>",
--       'Prev Diagnostic',
--     },
--     l = { '<cmd>lua vim.lsp.codelens.run()<cr>', 'CodeLens Action' },
--     q = { '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', 'Quickfix' },
--     r = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename' },
--     s = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document Symbols' },
--     S = {
--       '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>',
--       'Workspace Symbols',
--     },
--   },
--   s = {
--     name = 'Search',
--     b = { '<cmd>Telescope git_branches<cr>', 'Checkout branch' },
--     c = { '<cmd>Telescope colorscheme<cr>', 'Colorscheme' },
--     f = { '<cmd>Telescope find_files<cr>', 'Find File' },
--     h = { '<cmd>Telescope help_tags<cr>', 'Find Help' },
--     M = { '<cmd>Telescope man_pages<cr>', 'Man Pages' },
--     r = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
--     R = { '<cmd>Telescope registers<cr>', 'Registers' },
--     t = { '<cmd>Telescope live_grep<cr>', 'Text' },
--     k = { '<cmd>Telescope keymaps<cr>', 'Keymaps' },
--     C = { '<cmd>Telescope commands<cr>', 'Commands' },
--   },
-- }

-- which_key.setup(setup)
-- which_key.register(mappings, opts)
-- which_key.register(vmappings, vopts)

-- local opts = { noremap = true, silent = true }
--
-- local term_opts = { silent = true }
--
-- -- Shorten function name
-- local keymap = vim.api.nvim_set_keymap
--
-- --Remap space as leader key
-- keymap("", "<Space>", "<Nop>", opts)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "
--
-- -- Modes
-- --   normal_mode = "n",
-- --   insert_mode = "i",
-- --   visual_mode = "v",
-- --   visual_block_mode = "x",
-- --   term_mode = "t",
-- --   command_mode = "c",
--
-- -- Normal --
-- -- Better window navigation
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)
--
-- -- Resize with arrows
-- keymap("n", "<C-Up>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Down>", ":resize +2<CR>", opts)
-- keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
--
-- -- Naviagate buffers
-- keymap("n", "<S-l>", ":bnext<CR>", opts)
-- keymap("n", "<S-h>", ":bprevious<CR>", opts)
--
-- -- Move text up and down
-- keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
-- keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
--
-- -- Insert --
-- -- Press jk fast to enter
-- keymap("i", "jk", "<ESC>", opts)
--
-- -- Visual --
-- -- Stay in indent mode
-- keymap("v", "<", "<gv", opts)
-- keymap("v", ">", ">gv", opts)
--
-- -- Move text up and down
-- keymap("v", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- keymap("v", "p", '"_dP', opts)
--
-- -- Visual Block --
-- -- Move text up and down
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
--
-- -- Terminal --
-- -- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
--
-- -- Command --
-- -- Menu navigation
-- keymap("c", "<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { expr = true, noremap = true })
-- keymap("c", "<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { expr = true, noremap = true })
--
-- -- Telescope
-- keymap("n", "<leader>sf", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
-- keymap("n", "<leader>st", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
-- keymap("n", "<leader>sb", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)

-- }}}

-- cfilter plugin allows filtering down an existing quickfix list
cmd.packadd('cfilter')

-- colour scheme
vim.o.background = 'dark' -- or "light"
pde.pcall('theme failed to load because', cmd.colorscheme, 'horizon')

-- vim: fdm=marker
