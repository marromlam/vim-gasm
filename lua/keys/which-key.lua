local M = {}


M.config = function()
  local status_ok, which_key = pcall(require, "which-key")
  if not status_ok then
    return
  end
  which_key.setup {
    active = false,
    setup = {
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
          operators = false, -- adds help for operators like d, y, ...
          motions = false, -- adds help for motions
          text_objects = false, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
        spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
      },
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜",  -- symbol used between a key and it's label
        group = "+",      -- symbol prepended to a group
      },
      window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
      },
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
      show_help = true, -- show help message on the command line when the popup is visible
    },
  }
end


M.setup = function()
  local status_ok, wk = pcall(require, "which-key")
  if not status_ok then
    return
  end

  opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }
  vopts = {
    mode = "v", -- VISUAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
  }

  -- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
  -- see https://neovim.io/doc/user/map.html#:map-cmd

  vmappings = {
    ["/"] = { ":CommentToggle<CR>", "Comment" },
    ['h'] = "<cmd><Plug>SlimeLineSend<CR>",
    ["y"] = { "<cmd>OSCYank<CR>", "Yank using osc52" },
  }

  mappings = {
    ["w"] = { "<cmd>w!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },
    ["y"] = { "<cmd>OSCYank<CR>", "Yank using osc52" },
    -- ["/"] = { "<cmd>CommentToggle<CR>", "Comment" },

    -- Create splits {{{

    ["|"] = { "<cmd>vsp<CR>", "Create vertical split" },
    ["-"] = { "<cmd>sp<CR>", "Create horizontal split" },

    -- }}}


    ["e"] = { ":NvimTreeToggle<cr>", "Explorer" },
    ["§"] = { "<cmd>Telescope find_files<CR>", "Find File" },
    ["r"] = { "<cmd>Telescope live_grep<cr>", "Text" },

    -- Buffers {{{

    -- list buffers
    ["b"] = { "<cmd>Telescope buffers<cr>", "List Buffers" },
    ["1"] = { "<cmd>BufferLineGoToBuffer 1<cr>", "Go to buffer 1" },
    ["2"] = { "<cmd>BufferLineGoToBuffer 2<cr>", "Go to buffer 2" },
    ["3"] = { "<cmd>BufferLineGoToBuffer 3<cr>", "Go to buffer 3" },
    ["4"] = { "<cmd>BufferLineGoToBuffer 4<cr>", "Go to buffer 4" },
    ["5"] = { "<cmd>BufferLineGoToBuffer 5<cr>", "Go to buffer 5" },
    ["6"] = { "<cmd>BufferLineGoToBuffer 6<cr>", "Go to buffer 6" },
    ["7"] = { "<cmd>BufferLineGoToBuffer 7<cr>", "Go to buffer 7" },
    ["8"] = { "<cmd>BufferLineGoToBuffer 8<cr>", "Go to buffer 8" },
    ["9"] = { "<cmd>BufferLineGoToBuffer 9<cr>", "Go to buffer 9" },

    -- close current buffer
    ["x"] = { "<cmd>bdelete<CR>", "Close Buffer" },
    ["X"] = { "<cmd>bdelete!<CR>", "Close Buffer" },
    -- ["x"] = { "<cmd>BufferClose<CR>", "Close Buffer" },
    -- ["X"] = { "<cmd>BufferCloseAllButCurrent<CR>", "Close Buffer" },

    -- close all buffers
    ["z"] = { "<cmd>%bdelete<CR>", "Close All Buffers" },
    ["Z"] = { "<cmd>%bdelete!<CR>", "Close All Buffers" },
    ["o"] = { "<cmd>only<CR>", "Close All Buffers But Current" },

    -- less common shorcuts
    B = {
      name = "Buffers",
      j = { "<cmd>BufferPick<cr>", "jump to buffer" },
      b = { "<cmd>Telescope buffers<cr>", "Find buffer" },
      w = { "<cmd>BufferWipeout<cr>", "wipeout buffer" },
      e = {
        "<cmd>BufferCloseAllButCurrent<cr>",
        "close all but current buffer",
      },
      h = { "<cmd>BufferCloseBuffersLeft<cr>", "close all buffers to the left" },
      l = {
        "<cmd>BufferCloseBuffersRight<cr>",
        "close all BufferLines to the right",
      },
      D = {
        "<cmd>BufferOrderByDirectory<cr>",
        "sort BufferLines automatically by directory",
      },
      L = {
        "<cmd>BufferOrderByLanguage<cr>",
        "sort BufferLines automatically by language",
      },
    },
    -- }}}


    -- Packer {{{

    p = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },

    -- }}}

 
    -- Git {{{
    g = {
      name = "Git",
	    f = {"<cmd>Git fetch<cr>", "Git fetch"},
	    h = {"<cmd>diffget //2<cr>", "Get diff from left"},
      j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
      k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
      -- l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
	    l = {"<cmd>diffget //3<cr>", "Get diff from right"},
      
	    b = {"<cmd>Git blame<cr>", "Git Blame"},

      --p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
      r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
      R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
      -- s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
      
	    s = {"<cmd>Git<cr>", "Git Status"},

      P = { "<cmd>Git push<cr>", "Git push" },
      p = { "<cmd>Git pull<cr>", "Git pull" },
      u = {
        "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
        "Undo Stage Hunk",
      },
      o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
      -- b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
      C = {
        "<cmd>Telescope git_bcommits<cr>",
        "Checkout commit(for current file)",
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
      -- f = { "<cmd>silent FormatWrite<cr>", "Format" },
      f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
      i = { "<cmd>LspInfo<cr>", "Info" },
      j = {
        "<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = nvim.lsp.popup_border}})<cr>",
        "Next Diagnostic",
      },
      k = {
        "<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = nvim.lsp.popup_border}})<cr>",
        "Prev Diagnostic",
      },
      p = {
        name = "Peek",
        d = { "<cmd>lua require('lsp.peek').Peek('definition')<cr>", "Definition" },
        t = { "<cmd>lua require('lsp.peek').Peek('typeDefinition')<cr>", "Type Definition" },
        i = { "<cmd>lua require('lsp.peek').Peek('implementation')<cr>", "Implementation" },
      },
      q = { "<cmd>Telescope quickfix<cr>", "Quickfix" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
      S = {
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        "Workspace Symbols",
      },
    },

    -- }}}


    -- Search {{{

    f = {
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
      p = {
        "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
        "Colorscheme with Preview",
      },
    },

    -- }}}


    -- Terminal {{{

    T = {
      name = "Treesitter",
      i = { ":TSConfigInfo<cr>", "Info" },
    },

    t = {
      name = "Telescope",
      d = { "<cmd> lua require('pack-config.telescope').search_dotfiles()<CR>", "Telescope fictional-couscous" }
    },

    -- }}}


    -- Slime {{{

    [";"] = {
      name = "Run with slime",
      s = { "<cmd>SlimeSend1 MPLBACKEND='module://kitty' ipython<cr>", "Start interpreter" },
      r = { "<cmd>IPythonCellRun<CR>", "Run whole script"},
      R = { "<cmd>IPythonCellRunTime<CR>", "Run whole script time"},
      c = { "<cmd>IPythonCellExecuteCell<CR>", "Run current cell"},
      C = { "<cmd>IPythonCellExecuteCellJump<CR>", "Run current cell and jump"},
      l = { "<cmd>IPythonCellClear<CR>", "Clean Ipython"},
      x = { "<cmd>IPythonCellClose<CR>", "Close all plots"},
      p = { "<cmd>IPythonCellPrevCommand<CR>", "Run Previous Command"},
      Q = { "<cmd>IPythonCellRestart<CR>", "Restart Interpreter"},
      q = { "<cmd>SlimeSend1 exit<CR>", "Exit Intepreter"},
    },

    -- }}}

  }


  wk.register(mappings, opts)
  wk.register(vmappings, vopts)
end

return M


-- vim:foldmethod=marker
