return {
  {
    "willothy/flatten.nvim",
  },

  {
    "marromlam/sailor.vim",
    event = "VimEnter",
    run = "./install.sh",
  },

  {
    "uga-rosa/ccc.nvim",
    -- ft = {
    --   "lua",
    --   "vim",
    --   "typescript",
    --   "typescriptreact",
    --   "javascriptreact",
    --   "svelte",
    -- },
    event = "BufReadPost",
    cmd = { "CCCHighLighterToggle" },
    opts = function()
      local ccc = require("ccc")
      local p = ccc.picker
      p.hex.pattern = {
        [=[\v%(^|[^[:keyword:]])\zs#(\x\x)(\x\x)(\x\x)>]=],
        [=[\v%(^|[^[:keyword:]])\zs#(\x\x)(\x\x)(\x\x)(\x\x)>]=],
      }
      ccc.setup({
        win_opts = { border = mrl.ui.border },
        pickers = {
          p.hex,
          p.css_rgb,
          p.css_hsl,
          p.css_hwb,
          p.css_lab,
          p.css_lch,
          p.css_oklab,
          p.css_oklch,
        },
        highlighter = {
          auto_enable = true,
          excludes = {
            "dart",
            "lazy",
            "orgagenda",
            "org",
            "neogitstatus",
            "toggleterm",
          },
        },
      })
    end,
  },
  -- {
  --   "folke/todo-comments.nvim",
  --   event = "VeryLazy",
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   config = function()
  --     require("todo-comments").setup()
  --     as.command(
  --       "TodoDots",
  --       ("TodoQuickFix cwd=%s keywords=TODO,FIXME"):format(vim.g.vim_dir)
  --     )
  --   end,
  -- },
  --
  {
    "echasnovski/mini.bufremove",
    version = "*",
    keys = {
      {
        "<leader>bd",
        "<cmd> lua MiniBufremove.unshow()<cr>",
        "buffer: close buffer",
      },
    },
    config = function()
      require("mini.bufremove").setup()
    end,
  },
}
