-- All plugins
--
--


local present, _ = pcall(require, "packer_init")
local packer


if present then
  packer = require "packer"
else
  return false
end


return packer.startup(function()

  -- Packer {{{

  packer.use {
    "wbthomason/packer.nvim",
    event = "VimEnter"
  }

  -- }}}


  -- Defaults {{{

  -- Go to last position when opening files                              [MUST]
     packer.use {
       "farmergreg/vim-lastplace"
     }

  -- Sensible defaults
     packer.use {
       "tpope/vim-sensible"
     }

  -- Better Comments
     -- {"tpope/vim-commentary"},
  -- Change dates fast
     -- {"tpope/vim-speeddating"},

  -- Repeat stuff
     packer.use {
       "tpope/vim-repeat"
     }

  -- Text Navigation
     -- {"unblevable/quick-scope"},
  -- Highlight all matches under cursor
     -- {"RRethy/vim-illuminate"},
  -- Mouse support
     -- {"wincent/terminus"},

  -- }}}


  -- Navigation {{{

  -- {"tpope/vim-projectionist"}, -- Navigation of related files
  -- {"tpope/vim-vinegar"},

  packer.use {
    "christoomey/vim-tmux-navigator",
    disable = true,
    event = "BufWinEnter",
    config = function()
      -- require "appearance"
      -- let g:tmux_navigator_save_on_switch = 1
    end
  }

  packer.use {
    "knubie/vim-kitty-navigator",
    disable = false,
    event = "BufWinEnter",
    config = function()
      -- require "appearance"
    end
  }

  -- }}}


  -- packer.use {
  --   "jdhao/better-escape.vim",
  --   disable = false,
  --   event = "InsertEnter",
  --   config = function()
  --     require "pack-config.others".escape()
  --   end
  -- }




  -- Status Line and Bufferline {{{

  packer.use {
      "akinsho/nvim-bufferline.lua",
      disable = false,
      after = "nvim-base16.lua",
      config = function()
        require "pack-config.bufferline"
      end,
      setup = function()
        -- print('bufferline set')
        -- require "keys.mappings".bufferline()
      end
  }


  -- packer.use {
  --   "romgrk/barbar.nvim",
  --   disable = false,
  --   after = "nvim-base16.lua",
  --   config = function()
  --     -- require "packconf.bufferline"
  --     require("pack-config.barbar").setup()
  --     if nvim.builtin.bufferline.on_config_done then
  --       nvim.builtin.bufferline.on_config_done()
  --     end
  --   end,
  --   event = "BufWinEnter",
  -- }


  packer.use {
      "glepnir/galaxyline.nvim",
      disable = false,
      after = "nvim-base16.lua",
      config = function()
        -- require "pack-config.statusline"
        require "pack-config.my-galaxyline"
      end
  }

  -- }}}


  -- Colorful nvim {{{

  packer.use {
      "siduck76/nvim-base16.lua",
      after = "packer.nvim",
      config = function()
        require "appearance"
      end
  }

  packer.use {
    "norcalli/nvim-colorizer.lua",
    disable = false,
    event = "BufRead",
    config = function()
      require("pack-config.others").colorizer()
    end
  }

  -- }}}


  -- Treesitter {{{

  packer.use {
    "nvim-treesitter/nvim-treesitter",
    branch = "0.5-compat",
    -- run = ":TSUpdate",
    config = function()
      require("pack-config.treesitter").setup()
      if nvim.builtin.treesitter.on_config_done then
        nvim.builtin.treesitter.on_config_done(require "nvim-treesitter.configs")
      end
    end,
  }

  -- packer.use {
  --     "nvim-treesitter/nvim-treesitter",
  --     disable = false,
  --     event = "BufRead",
  --     config = function()
  --         require "pack-config.treesitter"
  --     end
  -- }

  -- }}}


  -- lsp stuff
  --
  -- packer.use {
  --     "kabouzeid/nvim-lspinstall",
  --     disable = false,
  --     event = "BufRead"
  -- }

  -- packer.use {
  --     "neovim/nvim-lspconfig",
  --     disable = false,
  --     after = "nvim-lspinstall",
  --     config = function()
  --         require "pack-config.lspconfig"
  --     end
  -- }

  -- packer.use {
  --     "onsails/lspkind-nvim",
  --     disable = false,
  --     event = "BufEnter",
  --     config = function()
  --         require("pack-config.others").lspkind()
  --     end
  -- }

  -- packer.use {
  --     "ray-x/lsp_signature.nvim",
  --     disable = false,
  --     after = "nvim-lspconfig",
  --     config = function()
  --         require("pack-config.others").signature()
  --     end
  -- }



  -- LSP {{{

  packer.use {
    "neovim/nvim-lspconfig",
    event = "VimEnter"
  }

  packer.use {
    "tamago324/nlsp-settings.nvim",
    event = "VimEnter"
  }

  packer.use {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VimEnter"
  }

  packer.use {
    "kabouzeid/nvim-lspinstall",
    event = "VimEnter",
    config = function()
      local lspinstall = require "lspinstall"
      lspinstall.setup()
      if nvim.builtin.lspinstall.on_config_done then
        nvim.builtin.lspinstall.on_config_done(lspinstall)
      end
    end
  }

  packer.use {
    "nvim-lua/popup.nvim",
    event = "VimEnter"
  }
  packer.use {
    "nvim-lua/plenary.nvim",
    event = "VimEnter"
  }
  packer.use {
    "tjdevries/astronauta.nvim",
    event = "VimEnter"
  }

  -- }}}


  -- Telescope {{{

  packer.use {
      "nvim-telescope/telescope.nvim",
      disable = false,
      cmd = "Telescope",
      requires = {
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          run = "make"
        },
        {
          "nvim-telescope/telescope-media-files.nvim"
        }
      },
      config = function()
          require "pack-config.telescope"
      end,
      setup = function()
          -- print('proper telescope setup')  
          -- require "keys.mappings".telescope()
      end
  }

  -- {
  --   "nvim-telescope/telescope.nvim",
  --   config = function()
  --     require("packconf.telescope").setup()
  --     if nvim.builtin.telescope.on_config_done then
  --       nvim.builtin.telescope.on_config_done(require "telescope")
  --     end
  --   end,
  -- },

  -- }}}


  -- Completion & Snippets {{{

  packer.use {
      "hrsh7th/nvim-compe",
      disable = false,
      event = "InsertEnter",
      config = function()
          require "pack-config.compe"
      end,
      wants = "LuaSnip",
      -- requires = {
      --     {
      --         "L3MON4D3/LuaSnip",
      --         wants = "friendly-snippets",
      --         event = "InsertCharPre",
      --         config = function()
      --             require "pack-config.luasnip"
      --         end
      --     },
      --     {
      --         "rafamadriz/friendly-snippets",
      --         event = "InsertCharPre"
      --     }
      -- }
  }

  packer.use {
    "windwp/nvim-autopairs",
    -- event = "InsertEnter",
    after = "nvim-compe",
    config = function()
      require "pack-config.autopairs"
      if nvim.builtin.autopairs.on_config_done then
        nvim.builtin.autopairs.on_config_done(require "nvim-autopairs")
      end
    end,
  }

  packer.use {
      "sbdchd/neoformat",
      disable = false,
      cmd = "Neoformat",
      setup = function()
	      -- print('neoformat set')
        -- require "keys.mappings".neoformat()
      end
  }

  -- }}}


  -- Nvimtree {{{

  packer.use {
      "kyazdani42/nvim-tree.lua",
      disable = false,
      cmd = "NvimTreeToggle",
      config = function()
        require "pack-config.nvimtree"
      end,
      setup = function()
       	-- print('nvim-tree set')
        -- require "keys.mappings".nvimtree()
      end
  }

  -- }}}


  -- Visual {{{

  packer.use {
      "kyazdani42/nvim-web-devicons",
      after = "nvim-base16.lua",
      config = function()
        -- require "pack-config.icons"
      end
  }

  packer.use {
      "nvim-lua/plenary.nvim",
      disable = false,
      event = "BufRead"
  }
  packer.use {
      "nvim-lua/popup.nvim",
      disable = false,
      after = "plenary.nvim"
  }

  packer.use {
      "windwp/nvim-autopairs",
      after = "nvim-compe",
      config = function()
          require "pack-config.autopairs"
      end
  }

  packer.use {
      "andymass/vim-matchup",
      disable = false,
      event = "CursorMoved"
  }
  -- }}}


  -- Tools {{{

  packer.use {
      "terrortylor/nvim-comment",
      disable = false,
      cmd = "CommentToggle",
      config = function()
          require("pack-config.others").comment()
      end,
      setup = function()
          -- print('proper comment setup')  
          -- require "keys.mappings".comment_nvim()
      end
  }


  packer.use {
    "airblade/vim-rooter",
    event = "BufReadPre",
    config = function()
      require("pack-config.rooter").setup()
      if nvim.builtin.rooter.on_config_done then
        nvim.builtin.rooter.on_config_done()
      end
    end,
    disable = not nvim.builtin.rooter.active,
  }

  -- }}}


  -- Debugging {{{

  packer.use {
    "mfussenegger/nvim-dap",
    event = "BufWinEnter",
    config = function()
      require("pack-config.dap").setup()
      if nvim.builtin.dap.on_config_done then
        nvim.builtin.dap.on_config_done(require "dap")
      end
    end,
    disable = not nvim.builtin.dap.active,
  }


  -- Debugger management
  packer.use {
    "Pocco81/DAPInstall.nvim",
    event = "BufWinEnter",
    -- event = "BufRead",
    disable = not nvim.builtin.dap.active,
  }

  -- }}}


  -- Start screen {{{

  packer.use {
    "glepnir/dashboard-nvim",
    disable = false,
    -- cmd = {
    --   "Dashboard",
    --   "DashboardNewFile",
    --   "DashboardJumpMarks",
    --   "SessionLoad",
    --   "SessionSave"
    -- },
    setup = function()
      require "pack-config.dashboard"
      -- print('proper dashboard setup')  
      -- require "keys.mappings".dashboard()
    end
  }

  -- Plug 'mhinz/vim-startify'

  -- }}}


  -- load autosave only if its globally enabled
  packer.use {
      disable = false,
      "Pocco81/AutoSave.nvim",
      config = function()
          require "pack-config.autosave"
      end,
      cond = function()
          return vim.g.auto_save == true
      end
  }

  -- smooth scroll
  packer.use {
      "karb94/neoscroll.nvim",
      disable = true,
      event = "WinScrolled",
      config = function()
          require("pack-config.others").neoscroll()
      end
  }

  packer.use {
      "Pocco81/TrueZen.nvim",
      disable = false,
      cmd = {
          "TZAtaraxis",
          "TZMinimalist",
          "TZFocus"
      },
      config = function()
          require "pack-config.zenmode"
      end,
      setup = function()
          -- print('proper zenmode setup')  
          -- require "keys.mappings".truezen()
      end
  }

  --   packer.use "alvan/vim-closetag" -- for html autoclosing tag

  packer.use {
      "lukas-reineke/indent-blankline.nvim",
      disable = false,
      event = "BufRead",
      setup = function()
          require("pack-config.others").blankline()
      end
  }

  -- Git {{{

  -- {"airblade/vim-gitgutter"},

  packer.use {
      "lewis6991/gitsigns.nvim",
      disable = false,
      after = "plenary.nvim",
      config = function()
          require "pack-config.gitsigns"
      end
  }

  packer.use {
      "tpope/vim-fugitive",
      disable = false,
      cmd = {
          "Git"
      },
      setup = function()
        -- print('proper git setup')  
	      --require "keys.mappings".fugitive()
      end
  }

  -- Merge tool for git
  packer.use {
    "samoshkin/vim-mergetool",
    disable = false,
    event = "BufRead"
  }

  -- }}}


  -- Whichkey {{{

  packer.use {
    "folke/which-key.nvim",
    disable = false,
    event = "BufWinEnter",
    config = function()
      require("keys.which-key").setup()
      if nvim.keys.on_config_done then
        nvim.keys.on_config_done(require "which-key")
      end
    end
  }

  -- }}}

end)


-- vim:foldmethod=marker
