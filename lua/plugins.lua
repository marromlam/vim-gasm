-- Thss file handles the main vim plugins, those nobody can live wihtout.


return {

  -- Packer {{{

  -- This is the plugin manager we are using in vim-gasm
  { "wbthomason/packer.nvim" },

  -- }}}


  -- LSP {{{

  { "neovim/nvim-lspconfig" },
  { "tamago324/nlsp-settings.nvim" },
  { "jose-elias-alvarez/null-ls.nvim" },
  {
    "kabouzeid/nvim-lspinstall",
    event = "VimEnter",
    config = function()
      local lspinstall = require "lspinstall"
      lspinstall.setup()
      if nvim.builtin.lspinstall.on_config_done then
        nvim.builtin.lspinstall.on_config_done(lspinstall)
      end
    end,
  },

  { "nvim-lua/popup.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "tjdevries/astronauta.nvim" },

  -- }}}


  -- Telescope {{{

  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("packconf.telescope").setup()
      if nvim.builtin.telescope.on_config_done then
        nvim.builtin.telescope.on_config_done(require "telescope")
      end
    end,
  },

  -- }}}


  -- Completion & Snippets {{{

  {
    "hrsh7th/nvim-compe",
    event = "InsertEnter",
    config = function()
      require("packconf.compe").setup()
      if nvim.builtin.compe.on_config_done then
        nvim.builtin.compe.on_config_done(require "compe")
      end
    end,
    -- wants = "vim-vsnip",
    -- requires = {
    -- {
    --   "hrsh7th/vim-vsnip",
    --   wants = "friendly-snippets",
    --   event = "InsertCharPre",
    -- },
    -- {
    --   "rafamadriz/friendly-snippets",
    --   event = "InsertCharPre",
    -- },
    -- },
  },
  {
    "hrsh7th/vim-vsnip",
    -- wants = "friendly-snippets",
    event = "InsertCharPre",
  },
  {
    "rafamadriz/friendly-snippets",
    event = "InsertCharPre",
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    -- event = "InsertEnter",
    after = "nvim-compe",
    config = function()
      require "packconf.autopairs"
      if nvim.builtin.autopairs.on_config_done then
        nvim.builtin.autopairs.on_config_done(require "nvim-autopairs")
      end
    end,
  },

  -- }}}


  -- Treesitter {{{

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "0.5-compat",
    -- run = ":TSUpdate",
    config = function()
      require("packconf.treesitter").setup()
      if nvim.builtin.treesitter.on_config_done then
        nvim.builtin.treesitter.on_config_done(require "nvim-treesitter.configs")
      end
    end,
  },

  -- }}}


  -- NvimTree {{{

  {
    "kyazdani42/nvim-tree.lua",
    -- event = "BufWinOpen",
    -- cmd = "NvimTreeToggle",
    -- commit = "fd7f60e242205ea9efc9649101c81a07d5f458bb",
    config = function()
      require("packconf.nvimtree").setup()
      if nvim.builtin.nvimtree.on_config_done then
        nvim.builtin.nvimtree.on_config_done(require "nvim-tree.config")
      end
    end,
  },

  {
    "lewis6991/gitsigns.nvim",

    config = function()
      require("packconf.gitsigns").setup()
      if nvim.builtin.gitsigns.on_config_done then
        nvim.builtin.gitsigns.on_config_done(require "gitsigns")
      end
    end,
    event = "BufRead",
  },

  -- }}}


  -- Whichkey {{{

  {
    "folke/which-key.nvim",
    config = function()
      require("keys.which-key").setup()
      if nvim.builtin.which_key.on_config_done then
        nvim.builtin.which_key.on_config_done(require "which-key")
      end
    end,
    event = "BufWinEnter",
  },

  -- }}}


  -- Comments {{{

  {
    "terrortylor/nvim-comment",
    event = "BufRead",
    config = function()
      local status_ok, nvim_comment = pcall(require, "nvim_comment")
      if not status_ok then
        return
      end
      nvim_comment.setup()
      if nvim.builtin.comment.on_config_done then
        nvim.builtin.comment.on_config_done(nvim_comment)
      end
    end,
  },

  -- }}}


  -- vim-rooter: Have the file system follow you around {{{

  {
    "airblade/vim-rooter",
    -- event = "BufReadPre",
    config = function()
      require("packconf.rooter").setup()
      if nvim.builtin.rooter.on_config_done then
        nvim.builtin.rooter.on_config_done()
      end
    end,
    disable = not nvim.builtin.rooter.active,
  },

  -- }}}


  -- Status Line and Bufferline {{{

  {
    "glepnir/galaxyline.nvim",
    config = function()
      -- require "packconf.galaxyline"
      -- require "packconf.neonline"
      require "packconf.my-galaxyline"
      -- require "packconf.evilline"
      -- require "packconf.eviline"
      if nvim.builtin.galaxyline.on_config_done then
        nvim.builtin.galaxyline.on_config_done(require "galaxyline")
      end
    end,
    event = "BufWinEnter",
    disable = not nvim.builtin.galaxyline.active,
  },


  {
    "romgrk/barbar.nvim",
    config = function()
      -- require "packconf.bufferline"
      require("packconf.bufferline").setup()
      if nvim.builtin.bufferline.on_config_done then
        nvim.builtin.bufferline.on_config_done()
      end
    end,
    event = "BufWinEnter",
  },

  -- }}}


  -- Debugging {{{

  {
    "mfussenegger/nvim-dap",
    -- event = "BufWinEnter",
    config = function()
      require("packconf.dap").setup()
      if nvim.builtin.dap.on_config_done then
        nvim.builtin.dap.on_config_done(require "dap")
      end
    end,
    disable = not nvim.builtin.dap.active,
  },


  -- Debugger management
  {
    "Pocco81/DAPInstall.nvim",
    -- event = "BufWinEnter",
    -- event = "BufRead",
    disable = not nvim.builtin.dap.active,
  },

  -- }}}


  -- Dashboard {{{

  {
    "ChristianChiarulli/dashboard-nvim",
    event = "BufWinEnter",
    config = function()
      require("packconf.dashboard").setup()
      if nvim.builtin.dashboard.on_config_done then
        nvim.builtin.dashboard.on_config_done(require "dashboard")
      end
    end,
    disable = not nvim.builtin.dashboard.active,
  },

  -- }}}


  -- Terminal {{{
  {
    "akinsho/nvim-toggleterm.lua",
    event = "BufWinEnter",
    config = function()
      require("packconf.terminal").setup()
      if nvim.builtin.terminal.on_config_done then
        nvim.builtin.terminal.on_config_done(require "toggleterm")
      end
    end,
    disable = not nvim.builtin.terminal.active,
  },

  -- }}}

}


-- vim: foldmethod=marker
