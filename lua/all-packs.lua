-- PLUGINS
-- Here we handle all plugins but the essential ones. Even if you
-- are full of crap here, vim should launch properly. We also define
-- here the main lua functions to load all packages with Packer.


-- Auto-install vim-plug {{{

local plugin_loader = {}


function plugin_loader:init()
  local execute = vim.api.nvim_command
  local fn = vim.fn

  local install_path = "~/.config/nvim/autoload/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
    execute "packadd packer.nvim"
  end

  local packer_ok, packer = pcall(require, "packer")
  if not packer_ok then
    return
  end

  local util = require "packer.util"

  packer.init {
    package_root = util.join_paths "~/.config/nvim/autoload/pack/",
    compile_path = util.join_paths("~/.config/nvim", "plugin", "packer_compiled.lua"),
    git = { clone_timeout = 300 },
    display = {
      open_fn = function()
        return util.float { border = "single" }
      end,
    },
  }

  self.packer = packer
  return self
end


function plugin_loader:load(configurations)
  return self.packer.startup(function(use)
    for _, plugins in ipairs(configurations) do
      for _, plugin in ipairs(plugins) do
        use(plugin)
      end
    end
  end)
end


-- }}}


nvim.plugins = {

  -- Defaults {{{

  -- Go to last position when opening files                              [MUST]
     {"farmergreg/vim-lastplace"},
  -- Sensible defaults
     {"tpope/vim-sensible"},
  -- Better Comments
     -- {"tpope/vim-commentary"},
  -- Change dates fast
     -- {"tpope/vim-speeddating"},
  -- Repeat stuff
     {"tpope/vim-repeat"},
  -- Text Navigation
     -- {"unblevable/quick-scope"},
  -- Highlight all matches under cursor
     -- {"RRethy/vim-illuminate"},
  -- Mouse support
     -- {"wincent/terminus"},

  -- }}}


  -- Navigation {{{

  {"tpope/vim-projectionist"}, -- Navigation of related files
  {"tpope/vim-vinegar"},

  -- Check whether we are running vim inside tmux or not
  -- if ($IS_TMUX==1)
  --   -- Seamlessly navigation between vim and tmux                          [MUST]
  --   {"christoomey/vim-tmux-navigator"}
  --   let g:tmux_navigator_save_on_switch = 1
  --   -- Vimux - tmux pannels runing files from vim
  --   {"benmills/vimux"}
  -- else
    {"knubie/vim-kitty-navigator"},
  -- endif

  -- }}}


  -- Visual {{{

  -- {"blueyed/vim-diminactive"},                -- Helps identifying active window
  -- {'TaDaa/vimade'},
  -- {"nathanaelkane/vim-indent-guides"},        -- Provides indentation guides
  -- {"vim-airline/vim-airline"},                -- Statusline

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

  -- Visualize folds
  {"arecarn/vim-clean-fold"},
  {"vim-scripts/folddigest.vim"},
  -- {"wincent/loupe"}, -- let g:LoupeVeryMagic=0

  -- Surround
  {"tpope/vim-surround"},
  -- auto set indent settings
  {"tpope/vim-sleuth"},
  -- Cool Icons
  {"kyazdani42/nvim-web-devicons"},
  -- Auto pairs for '(' '[' '{'
  {"jiangmiao/auto-pairs"},

  -- }}}


  -- Git {{{

  -- {"airblade/vim-gitgutter"},
  {"tpope/vim-fugitive"},
  {"samoshkin/vim-mergetool"},      -- Merge tool for git
  -- Plug 'mhinz/vim-startify'

  -- }}}


  -- Editor {{{

 -- {"bkad/CamelCaseMotion"},          -- Motions for inside camel case
 {"junegunn/vim-easy-align"},       -- Helps alignment
 {"kkoomen/vim-doge"},              -- Docblock generator
 {"lervag/vimtex"},                 -- Support for vimtex
 {"romainl/vim-cool"},              -- Awesome search highlighting
 {"tomtom/tcomment_vim"},           -- Better commenting
 {"ntpeters/vim-better-whitespace"},

  -- }}}


  -- Tools {{{

  {"dhruvasagar/vim-table-mode"},    -- Better handling for tables in markdown
  -- {"voldikss/vim-floaterm"},
  -- {"kassio/neoterm"},                -- REPL integration
  {"reedes/vim-pencil"},             -- Auto hard breaks for text files
  -- {"sedm0784/vim-you-autocorrect"},  -- Automatic autocorrect
  {"tpope/vim-obsession"},           -- Save sessions automatically

  -- CMake integration
  {"cdelledonne/vim-cmake"},

  -- CMake (lua) integration : In the future we should try to use these two
  -- {"Shatur/neovim-cmake"},
  -- {"skywind3000/asyncrun.vim"},
  -- }}}


  -- Syntax {{{

  -- Plug 'ibab/vim-snakemake'

  -- }}}


  -- juKitty {{{

  -- {"jpalardy/vim-slime"},
  -- {"hanschen/vim-ipython-cell"},

  {"marromlam/kitty-repl.nvim",
    config = function()
    require('kitty-runner').setup()
    end
  },

  -- }}}

}


-- Load packages {{{

return {
  init = function()
    return plugin_loader:init()
  end,
}

-- }}}


-- vim: foldmethod=marker
