-- plugins and plugin management


-- Bootstrap packer
local local_path = vim.fn.stdpath('data')
local install_path = local_path .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  print("Installing packer. Please, close and reopen neovim.")
  vim.cmd [[packadd packer.nvim]]
end


-- Autoplugins reloader.
-- This autocommand reloads neovim whenever you save the this init.lua file.
-- So it automatically sources your new configuration.
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])


-- Packer loader
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end


-- Packer interface
-- Have packer use a popup window. TODO: choose which interface is best
packer.init({
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
)


-- List of plugins to be installed
-- Here we list all plugins we need and we set their configurations and when
-- they should be loaded. The core idea is not to load a plugin we do not need
-- at a given moment. We just load them on require. Not all plugins follow this
-- rule, since there are some that belong to the heart of luavim.
return packer.startup(function(use)

  -- Non lazy-loaded {{{

  -- packer manages itself
  use 'wbthomason/packer.nvim'

  -- popup api
  use "nvim-lua/popup.nvim"

  -- lua functions
  use "nvim-lua/plenary.nvim"

  -- key mappings
  use {
    "folke/which-key.nvim",
    disable = false,
    config = function()
      require("luavim.plugins.config.whichkey")
    end
  }

  use {
    'dstein64/vim-startuptime',
    disable = false,
    cmd = 'StartupTime',
    config = function()
      vim.g.startuptime_tries = 20
      vim.g.startuptime_exe_args = { '+let g:auto_session_enabled = 0' }
    end,
  }

  -- theme
  use {
    -- "folke/tokyonight.nvim",
    "navarasu/onedark.nvim",
    disable = true,
  }

  use {
    'EdenEast/nightfox.nvim',
    disable = true,
  }

  use {
    -- "marromlam/gruvbox.nvim",
    "ellisonleao/gruvbox.nvim",
    -- "~/Projects/personal/gruvbox.nvim",
    disable = false,
    -- requires = {"rktjmp/lush.nvim"}
  }

  -- }}}

  -- UI {{{

  -- Start screen {{{

  use{
    'goolord/alpha-nvim',
    disable = false,
    config = function ()
       require("luavim.plugins.config.alpha")
    end
  }

  -- }}}

  -- Colors and icons {{{

  use {
    "siduck76/nvim-base16.lua",
    after = "packer.nvim"
  }

  use {
    "kyazdani42/nvim-web-devicons",
    after = "nvim-base16.lua",
    -- config = function()
    --   require "plugins.conf3.icons"
    -- end
  }

  -- }}}

  -- Statusline {{{

  use {
    "akinsho/nvim-bufferline.lua",
    disable = false,
    after = "nvim-web-devicons",
    config = function()
      require "luavim.plugins.config.bufferline"
    end,
  }

  use {
	  "SmiteshP/nvim-gps",
    -- event = {'BufRead', "CursorMoved", "BufWinEnter", "BufFilePost",
    --          "InsertEnter", "BufWritePost"},
    after = {"nvim-treesitter", "nvim-web-devicons"},
    config = function()
      require "luavim.plugins.config.gps"
    end
  }

  use {
    "nvim-lualine/lualine.nvim",
    disable = false,
    after = "nvim-web-devicons",
    config = function()
      require "luavim.plugins.config.lualine"
    end
  }

  -- }}}

  -- Identation {{{

  use {
    "lukas-reineke/indent-blankline.nvim",
    disable = not core.plugins.blankline,
    event = "BufRead",
    config = function()
      require("luavim.plugins.config.indentline")
    end
  }

  use {
    "norcalli/nvim-colorizer.lua",
    disable = not core.plugins.colorizer,
    event = "BufRead",
    config = function()
      require("luavim.plugins.config.colorizer").config()
    end
  }

  -- }}}

  -- Syntax {{{

  use {
    'nvim-treesitter/nvim-treesitter',
    disable = not core.plugins.treesitter,
    -- branch = "0.5-compat",
    -- event = {'BufRead', "CursorMoved", "BufWinEnter", "BufFilePost",
    --          "InsertEnter", "BufWritePost"},
    run = ':TSUpdate',
    config = function()
      require("luavim.plugins.config.treesitter")
    end,
    -- requires = {
    --   { 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' },
    --   { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
    --   {
    --     'nvim-treesitter/playground',
    --     keys = '<leader>E',
    --     cmd = { 'TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor' },
    --     setup = function()
    --       require('which-key').register { ['<leader>E'] = 'treesitter: highlight cursor group' }
    --     end,
    --     config = function()
    --       core.nnoremap('<leader>E', '<Cmd>TSHighlightCapturesUnderCursor<CR>')
    --     end,
    --   },
    -- },
  }

  -- use { 'David-Kunz/treesitter-unit', disable = true,
  --   event = 'BufRead',
  --   -- after = 'nvim-treesitter',
  --   config = function()
  --     local label = 'treesitter: select'
  --     core.xnoremap('iu', ':lua require"treesitter-unit".select()<CR>', label)
  --     core.xnoremap('au', ':lua require"treesitter-unit".select(true)<CR>', label)
  --     core.onoremap('iu', '<Cmd>lua require"treesitter-unit".select()<CR>', label)
  --     core.onoremap('au', '<Cmd>lua require"treesitter-unit".select(true)<CR>', label)
  --   end,
  -- }

  use {
    'lewis6991/spellsitter.nvim',
    disable = true,
    event = 'BufRead',
    ft = {"tex", "md", "rst"},
    after = 'nvim-treesitter',
    config = function()
      require('spellsitter').setup {}
    end,
  }

  -- }}}

  -- Nvimtree {{{

  use {
    "kyazdani42/nvim-tree.lua",
    disable = vim.g.elite_mode,
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = { "<leader>e" },
    config = function()
      require("plugins.conf3.nvimtree").config()
    end,
  }

  use {
    "vifm/vifm.vim",
    disable = true,
    config = function()
      -- require("plugins.conf3.nvimtree").config()
    end,
    setup = function()
     	-- print('nvim-tree set')
      -- require "keys.mappings".nvimtree()
    end
  }

  -- }}}

  -- Others {{{

  use {
    "lewis6991/gitsigns.nvim",
    disable = false,
    event = 'BufRead',
    config = function()
      require("luavim.plugins.config.gitsigns")
    end
  }

  use {
    "Pocco81/TrueZen.nvim",
    disable = true,
      cmd = {
          "TZAtaraxis",
          "TZMinimalist",
          "TZFocus"
      },
      config = function()
          require "plugins.conf3.zenmode"
      end,
      setup = function()
          -- print('proper zenmode setup')
          -- require "keys.mappings".truezen()
      end
  }

  use {
    'kevinhwang91/nvim-bqf',
    disable = false,
    event = 'QuickFixCmdPre',
    config = function()
      require("luavim.plugins.config.bqf")
    end,
  }

  -- }}}

  -- }}}

  -- Completion & Snippets {{{

  use {
    "rafamadriz/friendly-snippets",
    disable = not core.plugins.cmp,
    event = "InsertEnter",
  }

  use {
    'L3MON4D3/LuaSnip',
    disable = not core.plugins.cmp,
    after = "friendly-snippets",
    -- event = "VimEnter",
    -- event = "InsertEnter",
    -- after = "friendly-snippets",
    -- after = "nvim-cmp",
    -- config = function()
    --   require('plugins.configs.others').luasnip()
    -- end,
  }



  use {
    'hrsh7th/nvim-cmp',
    disable = not core.plugins.cmp,
    -- after = "friendly-snippets",
    after = { "LuaSnip" },
    requires = {
      { "saadparwaiz1/cmp_luasnip", after={"nvim-cmp"} },
      { "hrsh7th/cmp-nvim-lua", after="nvim-cmp" },
      -- required by lsp already  { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer", after="nvim-cmp" },
      { "hrsh7th/cmp-path", after="nvim-cmp" },
      { 'hrsh7th/cmp-nvim-lsp-document-symbol', after="nvim-cmp" },
      { 'hrsh7th/cmp-cmdline', after="nvim-cmp" },
      { 'f3fora/cmp-spell', after="nvim-cmp" },
      { 'petertriho/cmp-git', after="nvim-cmp" },
      { 'tzachar/cmp-tabnine', after="nvim-cmp", run = './install.sh'},
      -- { 'hrsh7th/cmp-copilot', after="nvim-cmp" },
    },
    config = function()
      require('luavim.plugins.config.cmp')
    end,
  }

  -- these two seem very interesting, but I cant get use to them ahaha
  use {
    'tzachar/cmp-fuzzy-path',
    disable = true,
    after = 'cmp-path',
    requires = { 'tzachar/fuzzy.nvim' }
  }

  use {
    'tzachar/cmp-fuzzy-buffer',
    disable = true,
     after = 'nvim-cmp',
     requires = { 'tzachar/fuzzy.nvim' }
  }

  use {
    'github/copilot.vim',
    disable = true,
    after = 'nvim-cmp',
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ''
      vim.g.copilot_filetypes = {
        ['*'] = true,
        gitcommit = false,
        NeogitCommitMessage = false,
      }
      core.imap('<c-a>', [[copilot#Accept("\<CR>")]], { expr = true, script = true })
    end,
  }

  use {
    "windwp/nvim-autopairs",
    disable = not core.plugins.cmp,
    after = "nvim-cmp",
    config = function()
      require("luavim.plugins.config.autopairs")
    end
  }

  use {
    "sbdchd/neoformat",
    disable = true,
    cmd = "Neoformat",
    setup = function()
	    -- print('neoformat set')
      -- require "keys.mappings".neoformat()
    end
  }

  -- }}}

  -- LSP {{{

  use {
    "neovim/nvim-lspconfig",
    disable = not core.plugins.lsp,
    ft = core.languages,
    requires = {
      { "hrsh7th/cmp-nvim-lsp"},
      {"williamboman/nvim-lsp-installer"},
      {"tamago324/nlsp-settings.nvim"},
      {"jose-elias-alvarez/null-ls.nvim"}, 
      {"antoinemadec/FixCursorHold.nvim"},
    },
    setup = function()
       core.load_after_ui("nvim-lspconfig", 0)
       vim.defer_fn(function()
          vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
       end, 0)
    end,
    config = function()
      require("luavim.lsp")
    end,
  }

  -- use {
  --   "williamboman/nvim-lsp-installer",
  --   -- event = "VimEnter",
  --   ft = core.languages,
  --   -- event = "CursorMoved",
  --   disable = not core.plugins.lsp,
  -- }
  --
  -- -- language server settings defined in json for
  -- use {
  --   "tamago324/nlsp-settings.nvim",
  --   -- event = "VimEnter",
  --   ft = core.languages,
  --   -- event = "CursorMoved",
  --   disable = not core.plugins.lsp,
  -- }
  --
  -- -- formatters and linters
  -- use {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   -- event = "VimEnter",
  --   ft = core.languages,
  --   -- event = "CursorMoved",
  --   disable = not core.plugins.lsp,
  -- }
  --
  -- -- fixes lsp doc highlight
  -- use {
  --   "antoinemadec/FixCursorHold.nvim",
  --   -- event = "VimEnter",
  --   ft = core.languages,
  --   -- event = "CursorMoved",
  --   disable = not core.plugins.lsp,
  --   -- event = 'BufReadPost'
  -- }

  -- }}}

  -- Debugging {{{

-- NO DEBUG YET --    use {
-- NO DEBUG YET --      'vim-test/vim-test', disable=false,
-- NO DEBUG YET --      cmd = { 'Test*' },
-- NO DEBUG YET --      keys = { '<localleader>tf', '<localleader>tn', '<localleader>ts' },
-- NO DEBUG YET --      setup = function()
-- NO DEBUG YET --        require('which-key').register({
-- NO DEBUG YET --          t = {
-- NO DEBUG YET --            name = '+vim-test',
-- NO DEBUG YET --            f = 'test: file',
-- NO DEBUG YET --            n = 'test: nearest',
-- NO DEBUG YET --            s = 'test: suite',
-- NO DEBUG YET --          },
-- NO DEBUG YET --        }, {
-- NO DEBUG YET --          prefix = '<localleader>',
-- NO DEBUG YET --        })
-- NO DEBUG YET --      end,
-- NO DEBUG YET --      config = function()
-- NO DEBUG YET --        vim.cmd [[
-- NO DEBUG YET --          function! ToggleTermStrategy(cmd) abort
-- NO DEBUG YET --            call luaeval("require('toggleterm').exec(_A[1])", [a:cmd])
-- NO DEBUG YET --          endfunction
-- NO DEBUG YET --
-- NO DEBUG YET --          let g:test#custom_strategies = {'toggleterm': function('ToggleTermStrategy')}
-- NO DEBUG YET --        ] ]
-- NO DEBUG YET --        vim.g['test#strategy'] = 'toggleterm'
-- NO DEBUG YET --        core.nnoremap('<localleader>tf', '<cmd>TestFile<CR>')
-- NO DEBUG YET --        core.nnoremap('<localleader>tn', '<cmd>TestNearest<CR>')
-- NO DEBUG YET --        core.nnoremap('<localleader>ts', '<cmd>TestSuite<CR>')
-- NO DEBUG YET --      end,
-- NO DEBUG YET --    }
-- NO DEBUG YET --
-- NO DEBUG YET --    use {
-- NO DEBUG YET --      'rcarriga/vim-ultest', disable=false,
-- NO DEBUG YET --      cmd = 'Ultest',
-- NO DEBUG YET --      wants = 'vim-test',
-- NO DEBUG YET --      event = { 'BufEnter *_test.*,*_spec.*' },
-- NO DEBUG YET --      requires = { 'vim-test/vim-test' },
-- NO DEBUG YET --      run = ':UpdateRemotePlugins',
-- NO DEBUG YET --      config = function()
-- NO DEBUG YET --        local test_patterns = { '*_test.*', '*_spec.*' }
-- NO DEBUG YET --        core.augroup('UltestTests', {
-- NO DEBUG YET --          {
-- NO DEBUG YET --            events = { 'BufWritePost' },
-- NO DEBUG YET --            targets = test_patterns,
-- NO DEBUG YET --            command = 'UltestNearest',
-- NO DEBUG YET --          },
-- NO DEBUG YET --        })
-- NO DEBUG YET --        core.nmap(']t', '<Plug>(ultest-next-fail)', {
-- NO DEBUG YET --          label = 'ultest: next failure',
-- NO DEBUG YET --          buffer = 0,
-- NO DEBUG YET --        })
-- NO DEBUG YET --        core.nmap('[t', '<Plug>(ultest-prev-fail)', {
-- NO DEBUG YET --          label = 'ultest: previous failure',
-- NO DEBUG YET --          buffer = 0,
-- NO DEBUG YET --        })
-- NO DEBUG YET --      end,
-- NO DEBUG YET --    }
-- NO DEBUG YET --

use {
  'mfussenegger/nvim-dap', disable = false,
  -- module = 'dap',
  -- keys = { '<localleader>dc', '<localleader>db' },
  -- setup = package_configure('dap').setup,
  -- config = package_configure('dap').config,
  -- requires = {
  --   {
  --     'rcarriga/nvim-dap-ui',
  --     after = 'nvim-dap',
  --     config = function()
  --       local dapui = require 'dapui'
  --       dapui.setup()
  --       core.nnoremap('<localleader>duc', dapui.close, 'dap-ui: close')
  --       core.nnoremap('<localleader>dut', dapui.toggle, 'dap-ui: toggle')
  --     end,
  --   },
  -- },
  config = function()
      local dap = require('dap')
      dap.adapters.lldb = {
        type = 'executable',
        command = '/home3/marcos.romero/.linuxbrew/bin/lldb-vscode', -- adjust as needed, must be absolute path
        name = 'lldb'
      }
      dap.configurations.cpp = {
        {
          name = 'Launch',
          type = 'lldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
          args = {},
          -- 💀
          -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
          --
          --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
          --
          -- Otherwise you might get the following error:
          --
          --    Error on launch: Failed to attach to the target process
          --
          -- But you should be aware of the implications:
          -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
          -- runInTerminal = false,
        },
      }
      -- If you want to use this for Rust and C, add something like this:
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp
  end
}

-- NO DEBUG YET --
-- NO DEBUG YET --    use { 'jbyuki/one-small-step-for-vimkind', disable = true,
-- NO DEBUG YET --      after = 'nvim-dap'
-- NO DEBUG YET --    }
-- NO DEBUG YET --
-- NO DEBUG YET --
-- NO DEBUG YET --  -- Debugger management
-- NO DEBUG YET --  use { "Pocco81/DAPInstall.nvim", disable = true,
-- NO DEBUG YET --    -- event = "BufWinEnter",
-- NO DEBUG YET --    -- event = "BufRead",
-- NO DEBUG YET --  }

  -- }}}

  -- Tools {{{

  -- vinegar allows easy navigation of netrw with dash
  use {
    "tpope/vim-vinegar",
    disable = false,
    keys = {'-'},
  }

  use{
    "numToStr/Comment.nvim",
    disable = false,
    keys = { "gc" },
    cmd = "CommentToggle",
    config = function ()
       require("luavim.plugins.config.comment")
    end,
  }

  use{
    'JoosepAlviste/nvim-ts-context-commentstring',
    disable = false,
    after = "Comment.nvim"
  }

  use {
    -- TODO : make shure this works properly
    "ojroques/vim-oscyank",
    disable = false,
    keys = "<leader>y",
    config = function()
      vim.cmd[[
      vnoremap <leader>y :OSCYank<CR>
      nmap <leader>y <Plug>OSCYank
      ]]
    end
  }

  -- provide unix cmd commands insid
  use {
    'tpope/vim-eunuch',
    disable = false,
    cmd = { "Delete", "Unlink", "Move", "Rename", "Chmod", "Mkdir", "Cfind",
            "Clocate", "Lfind/", "Wall", "SudoWrite", "SudoEdit" }
  }

  use {
    "moll/vim-bbye",
    disable = false,
    keys = { "<leader>c" }
  }

  -- Sensible defaults
  use {
    "tpope/vim-sensible",
    disable = true,
    -- event = "VimEnter"
  }

  -- Change dates fast
  use {
    "tpope/vim-speeddating",
    disable = true
  }

  -- Repeat stuff
  use {
    "tpope/vim-repeat",
    disable = false,
    keys = { "." },
  }

  -- Text Navigation
  use {
    "unblevable/quick-scope",
    disable = true,
    event = 'BufReadPost',
    config = function()
      vim.cmd[[
      " Trigger a highlight in the appropriate direction when pressing these keys:
      let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
      " Trigger a highlight only when pressing f and F.
      let g:qs_highlight_on_keys = ['f', 'F']
      ]]
    end
  }

  -- Highlight all matches under cursor
  use {
    "RRethy/vim-illuminate",
    disable = true
  }

  -- Mouse support
  use {
    "wincent/terminus",
    disable = true
  }

  -- }}}

  -- Session and project management {{{

  -- Go to last position when opening files
  use {
    'ethanholz/nvim-lastplace',
    disable = false,
    event = "BufWinEnter",
    config = function()
      require'nvim-lastplace'.setup {
        lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
        lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
        lastplace_open_folds = true
      }
    end
  }

  use {
    'ahmedkhalf/project.nvim',
    disable = true,
    config = function()
      require('project_nvim').setup()
    end,
  }

  use {
    'rmagatti/auto-session',
    disable = true,
    config = function()
      require('auto-session').setup {
        auto_session_root_dir = ('%s/session/auto/'):format(vim.fn.stdpath 'data'),
      }
    end,
  }

  use {
    'tpope/vim-projectionist',
    disable = true,
    -- config = package_configure 'vim-projectionist'
  }

  use {
    'noahfrederick/vim-skeleton',
    event = "BufNewFile",
    disable = false,
    config = function()
      vim.g.skeleton_template_dir = vim.fn.expand("~/.config/nvim") .. "/templates"
      vim.cmd [[
        let g:skeleton_replacements = {}
        function! g:skeleton_replacements.TITLE()
          return toupper(expand("%:t:r"))
        endfunction
      ]]
    end,
  }

  -- }}}

  -- Git {{{

  -- best git and vim integration
  use {
    "tpope/vim-fugitive",
    disable = false,
    cmd = { "Git", "Gedit", "Gsplit", "Gread", "Gblame", "OGlog" },
    setup = function()
	    require("luavim.plugins.config.fugitive")
    end
  }

  -- Merge tool for git
  use {
    "samoshkin/vim-mergetool",
    disable = true,
    after = "vim-fugitive"
  }

  use {
    'marromlam/git-worktree.nvim',
    disable = true,
    after = "telescope.nvim",
    keys = { '<leader>gt', '<leader>gw' },
    config = function()
      -- require("plugins.conf3.telescope").config()
      require("telescope").load_extension("git_worktree")
    end
  }

  use {
    'rlch/github-notifications.nvim',
    disable = true,
    -- don't load this plugin if the gh cli is not installed
    cond = function()
      return core.executable 'gh'
    end,
    requires = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  }

  -- }}}

  -- Navigation {{{

  -- use {
  --   "knubie/vim-kitty-navigator",
  --   disable = true,
  --   keys = {"<C-H>", "<C-J>", "<C-K>", "<C-L>" },
  --   config = function()
  --     vim.g.kitty_navigator_no_mappings = 1
  --   end,
  -- }

  -- use {
  --   'christoomey/vim-tmux-navigator',
  --   disable = true,
  --   keys = {"<C-H>", "<C-J>", "<C-K>", "<C-L>" },
  --   config = function()
  --     vim.g.tmux_navigator_no_mappings = 1
  --     -- Disable tmux navigator when zooming the Vim pane
  --     vim.g.tmux_navigator_disable_when_zoomed = 1
  --     vim.g.tmux_navigator_preserve_zoom = 1
  --     vim.g.tmux_navigator_save_on_switch = 1
  --     local is_tmux = os.getenv "TMUX"
  --     if is_tmux then
  --       require('which-key').register({
  --         ['<C-H>'] = { '<cmd>TmuxNavigateLeft<cr>' },
  --         ['<C-J>'] = { '<cmd>TmuxNavigateDown<cr>' },
  --         ['<C-K>'] = { '<cmd>TmuxNavigateUp<cr>' },
  --         ['<C-L>'] = { '<cmd>TmuxNavigateRight<cr>' },
  --       })
  --     else
  --       require('which-key').register({
  --         ['<C-H>'] = { '<cmd>KittyNavigateLeft<cr>' },
  --         ['<C-J>'] = { '<cmd>KittyNavigateDown<cr>' },
  --         ['<C-K>'] = { '<cmd>KittyNavigateUp<cr>' },
  --         ['<C-L>'] = { '<cmd>KittyNavigateRight<cr>' },
  --       })
  --     end
  --   end,
  -- }

  use {
    "marromlam/sailor.vim",
    disable = false,
    run = "./install.sh",
    -- keys = {"<C-H>", "<C-J>", "<C-K>", "<C-L>" },
  }

  use {
    "benmills/vimux",
    disable = true,
  }

  -- }}}

  -- juKitty {{{

  use {
    "jpalardy/vim-slime",
    disable = vim.g.elite_mode,
    keys = { "<leader>;" },
    config = function()
      require('plugins.conf3.slime')
    end
  }

  use {
    "hanschen/vim-ipython-cell",
    disable = vim.g.elite_mode,
    keys = { "<leader>;" },
    config = function()
      require('plugins.conf3.ipython_cell')
    end
  }

  use {
    "marromlam/kitty-repl.nvim",
    -- "~/Projects/personal/kitty-repl.nvim",
    disable = not vim.g.elite_mode,
    keys = { "<leader>;" },
    cmd = {"KittyREPLStart"},
    config = function()
      require('kitty-repl').setup()
      require "luavim.plugins.config.repl"
    end
  }

  use {
    'dccsillag/magma-nvim',
    run = ':UpdateRemotePlugins',
    disable = true,
    config = function ()
      vim.cmd[[
        nnoremap <silent><expr> <Leader>r  :MagmaEvaluateOperator<CR>
        nnoremap <silent>       <Leader>rr :MagmaEvaluateLine<CR>
        xnoremap <silent>       <Leader>r  :<C-u>MagmaEvaluateVisual<CR>
        nnoremap <silent>       <Leader>rc :MagmaReevaluateCell<CR>
        nnoremap <silent>       <Leader>rd :MagmaDelete<CR>
        nnoremap <silent>       <Leader>ro :MagmaShowOutput<CR>
        let g:magma_automatically_open_output = v:true
      ]]
    end
  }

  -- }}}

  -- Fuzzy finders {{{

  use {
    "nvim-telescope/telescope.nvim",
    disable = true,
    cmd = 'Telescope',
    keys = { '<leader><leader>', '<c-p>', '<leader>f', '<leader>g',
             '<leader>b'},
    module = 'telescope',
    config = function()
      require("luavim.plugins.config.telescope")
    end,
    -- use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    -- -- -- requires = {
    -- -- --   {
    -- -- --    "nvim-telescope/telescope-fzf-native.nvim",
    -- -- --    run = "make",
    -- -- --    after = 'telescope.nvim',
    -- -- --    config = function()
    -- -- --      require('telescope').load_extension 'fzf'
    -- -- --    end,
    -- -- --   },
    -- -- --   {
    -- -- --     'tzachar/fuzzy.nvim', disable=false,
    -- -- --     after = 'telescope.nvim',
    -- -- --     opt = true,
    -- -- --     requires = {'nvim-telescope/telescope-fzf-native.nvim'}
    -- -- --   },
    -- -- --   {
    -- -- --      "nvim-telescope/telescope-media-files.nvim",
    -- -- --      disable = true,
    -- -- --      after = 'telescope.nvim',
    -- -- --      setup = function()
    -- -- --         --require("mappings").telescope_media()
    -- -- --      end,
    -- -- --   },
    -- -- --   {
    -- -- --     'nvim-telescope/telescope-frecency.nvim',  -- FIX: this does not work yet
    -- -- --     after = 'telescope.nvim',
    -- -- --     requires = 'tami5/sqlite.lua',
    -- -- --   },
    -- -- --   {
    -- -- --     'camgraff/telescope-tmux.nvim',
    -- -- --     after = 'telescope.nvim',
    -- -- --     config = function()
    -- -- --       require('telescope').load_extension 'tmux'
    -- -- --     end,
    -- -- --   },
    -- -- --   {
    -- -- --     'nvim-telescope/telescope-smart-history.nvim',
    -- -- --     after = 'telescope.nvim',
    -- -- --     config = function()
    -- -- --       require('telescope').load_extension 'smart_history'
    -- -- --     end,
    -- -- --   },
    -- -- --   {
    -- -- --      "sudormrfbin/cheatsheet.nvim",
    -- -- --      disable = true,
    -- -- --      after = "telescope.nvim",
    -- -- --      config = function()
    -- -- --         require "plugins.conf3.cheatsheet".setup()
    -- -- --      end,
    -- -- --      setup = function()
    -- -- --         --require("mappings").chadsheet()
    -- -- --      end,
    -- -- --   },
    -- -- -- },
  }

  -- Snap aka. faster fuzzy-finding
  use {
    'camspiers/snap',
    disable = true,
    -- rocks = {'fzy'},
    after = {"which-key.nvim", "nvim-web-devicons"},
    config = function()
      require "plugins.conf3.snap".config()
    end,
  }

  use {
    'junegunn/fzf.vim',
    run = './install --bin',
    -- 'vijaymarupudi/nvim-fzf',
    disable = true
  } 

  use {
    'ibhagwan/fzf-lua',
    after = {"which-key.nvim", "nvim-web-devicons"},
    -- optional for icon support
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require "luavim.plugins.config.fzf"
    end,
  }

  -- }}}

  -- Language specific {{{

  use {
    "ibab/vim-snakemake",
    disable = false,
    ft = "snakemake"
  }

  -- markdown support
  use {
    'plasticboy/vim-markdown',
    disable = false,
    ft = {'markdown', 'rst'}
  }

  -- syntax highlighting for log files
  use {
    'mtdl9/vim-log-highlighting',
    disable = false,
    ft = 'log'
  }

  -- syntax highlighting for kitty conf file
  use {
    'fladson/vim-kitty',
    disable = false,
    ft = 'conf'
  }

  -- sets searchable path for filetypes like go so 'gf' works
  use {
    'tpope/vim-apathy',
    disable = false,
    ft = { 'go', 'python', 'javascript', 'typescript' }
  }

  use {
    "lervag/vimtex",
    disable = false,
    ft = "tex",
    config = function()
      require("luavim.plugins.config.vimtex")
    end,
  }

   -- CMake integration
   use {
     -- "cdelledonne/vim-cmake",
     "Shatur/neovim-cmake",
    requires = {'nvim-lua/plenary.nvim', "nvim-dap"},
    config = function()
      -- local Path = require('plenary.path')
      require('cmake').setup({
        -- cmake_executable = 'cmake', -- CMake executable to run.
        parameters_file = 'compile_parameters.json', -- JSON file to store information about selected target, run arguments and build type.
        -- build_dir = tostring(Path:new('{cwd}', 'build', '{os}-{build_type}')), -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values. Could be a function that return the path to the build directory.
        -- samples_path = tostring(script_path:parent():parent():parent() / 'samples'), -- Folder with samples. `samples` folder from the plugin directory is used by default.
        -- default_projects_path = tostring(Path:new(vim.loop.os_homedir(), 'Projects')), -- Default folder for creating project.
        configure_args = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1' }, -- Default arguments that will be always passed at cmake configure step. By default tells cmake to generate `compile_commands.json`.
        build_args = {}, -- Default arguments that will be always passed at cmake build step.
        on_build_output = nil, -- Callback which will be called on every line that is printed during build process. Accepts printed line as argument.
        quickfix_height = 10, -- Height of the opened quickfix.
        quickfix_only_on_error = false, -- Open quickfix window only if target build failed.
        copy_compile_commands = true, -- Copy compile_commands.json to current working directory.
        dap_configuration = { type = 'lldb', request = 'launch' }, -- DAP configuration. By default configured to work with `lldb-vscode`.
        dap_open_command = require('dap').repl.open, -- Command to run after starting DAP session. You can set it to `false` if you don't want to open anything or `require('dapui').open` if you are using https://github.com/rcarriga/nvim-dap-ui
      })
    end
   }

   -- CMake (lua) integration : In the future we should try to use these two
   -- {"Shatur/neovim-cmake"},
   -- {"skywind3000/asyncrun.vim"},

  use {
    'tpope/vim-surround',
    disable = true,
    event = 'BufRead',
  }

  use {
    'chrisbra/csv.vim',
    disable = false,
    ft = 'csv',
  }
  -- }}}

  -- Terminal {{{

  use {
    -- TODO : fix terminal not launching
    "akinsho/nvim-toggleterm.lua",
    disable = false,
    keys = { "<C-t>", "<leader>gg", "<leader>e" },
    cmd = {"Htop", "LazyGit", "Vifm"},
    config = function()
      -- require("luavim.plugins.config.terminal")
      require("luavim.plugins.config.toggleterm").config()
      require("luavim.plugins.config.toggleterm").setup()
    end
  }

  -- }}}

  -- Reloadder {{{
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end

  -- }}}

end)


-- vim:fdm=marker
