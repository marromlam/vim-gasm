return {

  -- markdown support
  {
    "plasticboy/vim-markdown",
    disable = false,
    ft = { "markdown", "rst" },
  },

  -- syntax highlighting for log files
  {
    "mtdl9/vim-log-highlighting",
    disable = false,
    ft = "log",
  },

  -- syntax highlighting for kitty conf file
  {
    "fladson/vim-kitty",
    disable = false,
    ft = "conf",
  },

  -- sets searchable path for filetypes like go so 'gf' works
  {
    "tpope/vim-apathy",
    disable = false,
    ft = { "go", "python", "javascript", "typescript" },
  },

  {
    "lervag/vimtex",
    disable = false,
    ft = "tex",
    config = function()
      require("luavim.plugins.config.vimtex")
    end,
  },

  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    requires = { { "nvim-lua/plenary.nvim" } },
    config = function()
      require("crates").setup()
    end,
  },

  {
    "lbrayner/vim-rzip",
    disable = false,
    ft = { "zip", "docx", "xlsx", "pptx" },
    config = function()
      vim.cmd([[
        " let g:rzipPlugin_extra_ext = '*.docx'
      ]])
    end,
  },

  {
    "tpope/vim-surround",
    event = "InsertEnter",
  },

  {
    "chrisbra/csv.vim",
    ft = "csv",
  },
}

-- vim: fdm=marker
