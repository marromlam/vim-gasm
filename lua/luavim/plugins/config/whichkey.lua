local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

-- Custom mappings {{{

-- wk.register({'i'}, 'ax', '<cmd>Htop<cr>', "oladf")
-- Move current line / block with Alt-j/k ala vscode.
wk.register({
  ["<A-j>"] = { "<Esc>:m .+1<CR>==gi" },
  ["<A-k>"] = { "<Esc>:m .-2<CR>==gi" },
  ["<A-Up>"] = { "<C-\\><C-N><C-w>k" },
  ["<A-Down>"] = { "<C-\\><C-N><C-w>j" },
  ["<A-Left>"] = { "<C-\\><C-N><C-w>h" },
  ["<A-Right>"] = { "<C-\\><C-N><C-w>l" },
  -- navigate tab completion with <c-j> and <c-k> runs conditionally
  ["<C-j>"] = { 'pumvisible() ? "\\<C-n>" : "\\<C-j>"' },
  ["<C-k>"] = { 'pumvisible() ? "\\<C-p>" : "\\<C-k>"' },
}, { mode = "i", buffer = nil, silent = true, noremap = true, nowait = true })

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

vim.api.nvim_set_keymap("n", "]q", ":cnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[q", ":cprev<CR>", { noremap = true, silent = true })
wk.register({
  -- ["<Tab>"]   = { ":BufferLineCycleNext<CR>", "Go to next buffer" },
  -- ["<S-Tab>"] = { ":BufferLineCyclePrev<CR>", "Go to previous buffer" },
  ["<Tab>"] = { ":bnext<CR>", "Go to next buffer" },
  ["<S-Tab>"] = { ":bprevious<CR>", "Go to previous buffer" },
  ["<A-j>"] = { ":move .+1<CR>==" },
  ["<A-k>"] = { ":move .-2<CR>==" },
  ["]q"] = { "Next Quickfix element" },
  ["[q"] = { "Previous Quickfix element" },
  -- ["<C-q>"]   = { ":call QuickFixToggle()<CR>" },
}, { mode = "n", buffer = nil, silent = true, noremap = true, nowait = true })
-- wk.register({'n'}, "gcc" , ":CommentToggle<cr>", "Quit")
-- wk.register({'v'}, "gc" , ":CommentToggle<cr>", "Quit")

wk.register({
  -- closing buffers
  ["x"] = { ":bd<CR>", "Close buffer" },
  ["X"] = { ":bd!<CR>", "Force close buffer" },
  ["o"] = { ":only<CR>", "Show only current buffer" },
  -- ["x"] = { "<cmd>bdelete<CR>", "Close Buffer" },
  -- ["X"] = { "<cmd>bdelete!<CR>", "Close Buffer" },
  -- ["x"] = { "<cmd>BufferClose<CR>", "Close Buffer" },
  -- ["X"] = { "<cmd>BufferCloseAllButCurrent<CR>", "Close Buffer" },
  ["z"] = { "<cmd>%bdelete<CR>", "Close All Buffers" },
  ["Z"] = { "<cmd>%bdelete!<CR>", "Close All Buffers" },
  ["w"] = { ":w<CR>", "Save" },
  ["q"] = { ":q<CR>", "Quit" },
  ["W"] = { "<cmd>w!<CR>", "Save" },
  ["Q"] = { "<cmd>q!<CR>", "Quit" },
  -- switching buffers
  ["1"] = { "<cmd>BufferLineGoToBuffer 1<cr>", "Go to buffer 1" },
  ["2"] = { "<cmd>BufferLineGoToBuffer 2<cr>", "Go to buffer 2" },
  ["3"] = { "<cmd>BufferLineGoToBuffer 3<cr>", "Go to buffer 3" },
  ["4"] = { "<cmd>BufferLineGoToBuffer 4<cr>", "Go to buffer 4" },
  ["5"] = { "<cmd>BufferLineGoToBuffer 5<cr>", "Go to buffer 5" },
  ["6"] = { "<cmd>BufferLineGoToBuffer 6<cr>", "Go to buffer 6" },
  ["7"] = { "<cmd>BufferLineGoToBuffer 7<cr>", "Go to buffer 7" },
  ["8"] = { "<cmd>BufferLineGoToBuffer 8<cr>", "Go to buffer 8" },
  ["9"] = { "<cmd>BufferLineGoToBuffer 9<cr>", "Go to buffer 9" },
  -- yank to system keyboard
  ["y"] = { "<cmd>OSCYank<CR>", "Yank using osc52" },
  -- creating splits
  ["|"] = { "<cmd>vsp<CR>", "Create vertical split" },
  ["-"] = { "<cmd>sp<CR>", "Create horizontal split" },
}, { mode = "n", buffer = nil, silent = true, noremap = true, nowait = true, prefix = "<leader>" })

-- }}}

local mappings = {
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["/"] = { "<cmd>lua require('Comment').toggle()<CR>", "Comment" },
  ["c"] = { "<cmd>Bdelete! %d<CR>", "Close Buffer" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["f"] = { "<cmd>Telescope find_files<cr>", "Find files" },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },

  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = {
      "<cmd>Telescope lsp_document_diagnostics<cr>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      '<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>',
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = 'single'}})<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    t = { "<cmd>Telescope live_grep<cr>", "Text" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
  },
}

local vopts = {
  mode = "v", -- VISUAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}
local vmappings = {
  ["/"] = { "<ESC><CMD>lua require('Comment.api').gc(vim.fn.visualmode())<CR>", "Comment" },
}

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
