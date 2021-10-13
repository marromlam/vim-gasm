-- ALL PLUGINS
--
-- All pluging will be lazyloaded here


local present, _ = pcall(require, "packer_load")
local packer


if present then
  packer = require "packer"
else
  return false
end


return packer.startup(function()

  -- Colorful nvim {{{

  packer.use {
      "siduck76/nvim-base16.lua",
      disable = false,
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
      require("pack-config.colorizer").config()
    end
  }

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
      requires = {
          {
              "L3MON4D3/LuaSnip",
              wants = "friendly-snippets",
              event = "InsertCharPre",
              config = function()
                  require "pack-config.luasnip"
              end
          },
          {
              "rafamadriz/friendly-snippets",
              event = "InsertCharPre"
          }
      }
  }

  packer.use {
      "windwp/nvim-autopairs",
      after = "nvim-compe",
      config = function()
          require "pack-config.autopairs"
      end
  }


  -- packer.use {
  --   "windwp/nvim-autopairs",
  --   -- event = "InsertEnter",
  --   after = "nvim-compe",
  --   config = function()
  --     require "pack-config.autopairs"
  --     if nvim.builtin.autopairs.on_config_done then
  --       nvim.builtin.autopairs.on_config_done(require "nvim-autopairs")
  --     end
  --   end,
  -- }

  packer.use {
    'tzachar/compe-tabnine', 
    disable = false,
    after = 'nvim-compe',
    run='./install.sh'
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
    disable = true,
  }


  -- Debugger management
  packer.use {
    "Pocco81/DAPInstall.nvim",
    event = "BufWinEnter",
    -- event = "BufRead",
    disable = true,
  }

  -- }}}


  -- Defaults {{{

  -- Go to last position when opening files                              [MUST]
  packer.use {
    "farmergreg/vim-lastplace",
    disable = false,
    -- event = "VimEnter"
  }

  packer.use {
    -- "fcpg/vim-osc52",
    "ojroques/vim-oscyank",
    disable = false,
  }

  -- Sensible defaults
  packer.use {
    "tpope/vim-sensible",
    disable = true,
    event = "VimEnter"
  }

  -- Better Comments
  packer.use {
    "tpope/vim-commentary",
    disable = true
  }

  -- Change dates fast
  packer.use {
    "tpope/vim-speeddating",
    disable = true
  }

  -- Repeat stuff
  packer.use {
    "tpope/vim-repeat",
    disable = true,
    event = "VimEnter"
  }

  -- Text Navigation
  packer.use {
    "unblevable/quick-scope",
    disable = true
  }

  -- Highlight all matches under cursor
  packer.use {
    "RRethy/vim-illuminate",
    disable = true
  }

  -- Mouse support
  packer.use {
    "wincent/terminus",
    disable = true
  }

  -- }}}


  -- Editor {{{

  -- load autosave only if its globally enabled
  packer.use {
      "Pocco81/AutoSave.nvim",
      disable = true,
      config = function()
          require "pack-config.autosave"
      end,
      cond = function() return false end
  }

  -- smooth scroll
  packer.use {
      "karb94/neoscroll.nvim",
      disable = true,
      event = "WinScrolled",
      config = function()
          require("pack-config.neoscroll").config()
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

  packer.use {
    "lukas-reineke/indent-blankline.nvim",
    disable = false,
    event = "BufRead",
    config = function()
      require("pack-config.blankline").config()
    end
  }

  -- }}}


  -- Git {{{

  -- add line by line git status for document
  packer.use {
    "airblade/vim-gitgutter",
    disable = true
  }
  packer.use {
    "lewis6991/gitsigns.nvim",
    disable = false,
    after = "plenary.nvim",
    config = function()
      require "pack-config.gitsigns"
    end
  }

  -- best git and vim integration
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
    disable = true,
    after = "vim-fugitive"
  }

  -- }}}


  -- LSP {{{

  -- lsp stuff
  --
  packer.use {
      "kabouzeid/nvim-lspinstall",
      disable = false,
      event = "BufRead"
  }

  packer.use {
      "neovim/nvim-lspconfig",
      disable = false,
      after = "nvim-lspinstall",
      config = function()
          require "pack-config.lspconfig"
      end
  }

  packer.use {
      "onsails/lspkind-nvim",
      disable = false,
      event = "BufEnter",
      config = function()
          require("pack-config.lspkind").config()
      end
  }

  packer.use {
      "ray-x/lsp_signature.nvim",
      disable = false,
      after = "nvim-lspconfig",
      config = function()
          require("pack-config.signature").config()
      end
  }

  -- packer.use {
  --   "neovim/nvim-lspconfig",
  --   -- event = "VimEnter"
  -- }

  packer.use {
    "tamago324/nlsp-settings.nvim",
    disable = true,
    -- event = "VimEnter"
  }

  packer.use {
    "jose-elias-alvarez/null-ls.nvim",
    disable = true,
    -- event = "VimEnter"
  }

  -- packer.use {
  --   "kabouzeid/nvim-lspinstall",
  --   -- event = "VimEnter",
  --   config = function()
  --     local lspinstall = require "lspinstall"
  --     lspinstall.setup()
  --     if nvim.builtin.lspinstall.on_config_done then
  --       nvim.builtin.lspinstall.on_config_done(lspinstall)
  --     end
  --   end
  -- }

  -- packer.use {
  --   "tjdevries/astronauta.nvim",
  --   event = "VimEnter"
  -- }

  -- }}}


  -- juKitty {{{

  packer.use {
    "jpalardy/vim-slime",
    disable = true,
    config = function()
      require('pack-config.slime')
    end
  }
  packer.use {
    "hanschen/vim-ipython-cell",
    disable = true,
    config = function()
      require('pack-config.ipython_cell')
    end
  }

  packer.use {
    "marromlam/kitty-repl.nvim",
    disable = false,
    event = "BufEnter",
    config = function()
      require('kitty-repl').setup()
      require('pack-config.kitty-repl')
    end
  }

  -- }}}


  -- Navigation {{{

  -- Navigation of related files
  packer.use {
    "tpope/vim-projectionist",
    disable = true
  }

  -- vinegar allows easy navigation of netrw with dash
  packer.use {
    "tpope/vim-vinegar",
    disable = false,
    event = "BufWinEnter",
  }

  packer.use {
    "christoomey/vim-tmux-navigator",
    disable = false,
    config = function()
      vim.g.tmux_navigator_save_on_switch = 1
    end,
    cond = function() 
      local is_tmux = os.getenv "TMUX"
      if is_tmux then
        return true
      else
        return false
      end
    end
  }

  packer.use {
    "benmills/vimux",
    disable = true,
    event = "BufWinEnter",
    config = function()
      -- require "appearance"
    end,
    cond = function() return false end
  }

  packer.use {
    "knubie/vim-kitty-navigator",
    disable = true,
    event = "BufWinEnter",
    config = function()
      -- require "appearance"
    end,
    cond = function() return true end
  }

  -- }}}


  -- Nvimtree {{{

  packer.use {
    "kyazdani42/nvim-tree.lua",
    disable = false,
    cmd = "NvimTreeToggle",
    config = function()
      require("pack-config.nvimtree").config()
    end,
    setup = function()
     	-- print('nvim-tree set')
      -- require "keys.mappings".nvimtree()
    end
  }

  -- }}}


  -- Packer {{{

  packer.use {
    "wbthomason/packer.nvim",
    event = "VimEnter"
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


  -- Statusline {{{

  packer.use {
    "akinsho/nvim-bufferline.lua",
    disable = false,
    -- after = "nvim-base16.lua",
    event = "BufWinEnter",
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
  --   disable = true,
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
      --require "pack-config.statusline"
      require "pack-config.galaxyline"
    end
  }

  -- Statusline with airline
  packer.use {
    "vim-airline/vim-airline",
    disable = true,
    config = function()
      require "pack-config.airline"
    end
  }

  -- }}}


  -- Treesitter {{{

  -- packer.use {
  --   "nvim-treesitter/nvim-treesitter",
  --   branch = "0.5-compat",
  --   -- run = ":TSUpdate",
  --   config = function()
  --     require("pack-config.treesitter").setup()
  --     if nvim.builtin.treesitter.on_config_done then
  --       nvim.builtin.treesitter.on_config_done(require "nvim-treesitter.configs")
  --     end
  --   end,
  -- }

  packer.use {
    "nvim-treesitter/nvim-treesitter",
    disable = false,
    event = "BufRead",
    config = function()
        require "pack-config.treesitter"
    end
  }

  packer.use {
    "ibab/vim-snakemake",
    disable = false,
    event = "BufRead",
  }


  -- }}}


  -- Telescope {{{

  packer.use {
    "nvim-telescope/telescope.nvim",
    disable = false,
    after = "plenary.nvim",
    requires = {
       {
          "nvim-telescope/telescope-fzf-native.nvim",
          run = "make",
       },
       {
          "nvim-telescope/telescope-media-files.nvim",
          disable = false,
          setup = function()
             --require("mappings").telescope_media()
          end,
       },
       {
          "sudormrfbin/cheatsheet.nvim",
          disable = false,
          after = "telescope.nvim",
          config = function()
             require "pack-config.cheatsheet".setup()
          end,
          setup = function()
             --require("mappings").chadsheet()
          end,
       },
    },
    config = function()
       require "pack-config.telescope"
    end,
    setup = function()
        -- print('proper telescope setup')  
        -- require "keys.mappings".telescope()
    end
  }

  -- packer.use {
  --   "nvim-telescope/telescope.nvim",
  --   after = "plenary.nvim",
  --   config = function()
  --     require("pack-config.telescope").setup()
  --     if nvim.builtin.telescope.on_config_done then
  --       nvim.builtin.telescope.on_config_done(require "telescope")
  --     end
  --   end,
  -- }

  -- Snap / faster fuzzy-finding
  packer.use {
    'camspiers/snap',
    disable = true,
    after = {"which-key.nvim", "nvim-web-devicons"},
    config = function()
      require "pack-config.snap".config()
    end,
  }

  -- }}}


  -- Terminal {{{
  packer.use {
    "akinsho/nvim-toggleterm.lua",
    disable = false,
    event = "BufWinEnter",
    config = function()
      require("pack-config.terminal").config()
      require("pack-config.terminal").setup()
      -- if nvim.builtin.terminal.on_config_done then
      --   nvim.builtin.terminal.on_config_done(require "toggleterm")
      -- end
    end
  }

  -- }}}


  -- Tools {{{

  packer.use {
    "terrortylor/nvim-comment",
    disable = false,
    event = "BufWinEnter",
    cmd = "CommentToggle",
    config = function()
      require("pack-config.comment").config()
    end
  }


  packer.use {
    "airblade/vim-rooter",
    disable = true,
    event = "BufReadPre",
    config = function()
      require("pack-config.rooter").setup()
    end,
  }


  packer.use {
    "lervag/vimtex",
    disable = False,
    event = "BufWinEnter",
    ft = "tex",
    config = function()
      require("pack-config.vimtex")
    end,
  }

  -- CMake integration
  -- packer.use {
  --   "cdelledonne/vim-cmake",
  -- }

  -- CMake (lua) integration : In the future we should try to use these two
  -- {"Shatur/neovim-cmake"},
  -- {"skywind3000/asyncrun.vim"},

  -- }}}


  -- Visual {{{

  -- Helps identifying active window
  packer.use {
    "blueyed/vim-diminactive",
    disable = true
  }
  packer.use {
    'TaDaa/vimade',
    disable = true
  }
  
  -- Provides indentation guides
  packer.use {
    "nathanaelkane/vim-indent-guides",
    disable = true
  }
  packer.use {
    "glepnir/indent-guides.nvim",
    disable = true
  }

  -- fancy icons
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

  -- Themes
  -- {"morhetz/gruvbox"},
  -- {"joshdick/onedark.vim"},
  -- {"sainnhe/gruvbox-material"},
  -- {'marko-cerovac/material.nvim'},
  -- {"folke/tokyonight.nvim"},
  -- {"rktjmp/lush.nvim"},
  -- {"npxbr/gruvbox.nvim"},
  -- {"shaunsingh/nord.nvim"},
  -- {"romgrk/doom-one.vim"},
  -- {"projekt0n/github-nvim-theme",
  -- 	config = function()
  -- 		local _time = os.date("*t")
  -- 		local themeStyle
  -- 		if _time.hour < 8 then
  -- 			themeStyle = "dark"
  -- 		elseif _time.hour >= 8 and _time.hour < 16 then
  -- 			themeStyle = "light"
  -- 		else
  -- 			themeStyle = "dimmed"
  -- 		end
  -- 		require("github-theme").setup({
  -- 			themeStyle = themeStyle,
  -- 		})
  -- 	end,
  -- },

  -- Extends % to language specific words
  packer.use {
      "andymass/vim-matchup",
      disable = false,
      event = "CursorMoved"
  }

  -- Visualize folds
  packer.use {
    "arecarn/vim-clean-fold",
    disable = true,
    event = "BufWinEnter",
  }
  packer.use {
    "vim-scripts/folddigest.vim",
    disable = true,
    event = "BufWinEnter",
    config = function()
      require("pack-config.folding")
    end,
  }

  -- Surround
  packer.use {
    "tpope/vim-surround",
    disable = true
  }

  -- Auto set indent settings
  packer.use {
    "tpope/vim-sleuth",
    disable = true
  }

  -- Auto pairs for '(' '[' '{'
  packer.use {
    "jiangmiao/auto-pairs",
    disable = true
  }

  -- }}}


  -- Whichkey {{{

  packer.use {
    "folke/which-key.nvim",
    disable = false,
    -- event = "BufWinEnter",
    config = function()
      require("keys.which-key").config()
      require("keys.which-key").setup()
    end
  }

  -- }}}

end)


-- vim:foldmethod=marker
