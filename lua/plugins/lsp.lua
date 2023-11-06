return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      keys[#keys + 1] = { "gh", "<cmd>lua vim.lsp.buf.hover()<cr>" }
      -- disable a keymap
      keys[#keys + 1] = { "gD", false }
      keys[#keys + 1] = { "gK", false }
    end,
  },
  {
    "DNLHC/glance.nvim",
    opts = {
      preview_win_opts = { relativenumber = false },
      theme = { enable = true },
    },
    keys = {
      { "gD", "<Cmd>Glance definitions<CR>", desc = "lsp: glance definitions" },
      { "gR", "<Cmd>Glance references<CR>", desc = "lsp: glance references" },
      {
        "gY",
        "<Cmd>Glance type_definitions<CR>",
        desc = "lsp: glance type definitions",
      },
      {
        "gM",
        "<Cmd>Glance implementations<CR>",
        desc = "lsp: glance implementations",
      },
    },
  },
  {
    "smjonas/inc-rename.nvim",
    opts = { hl_group = "Visual", preview_empty_name = true },
    keys = {
      {
        "<leader>rn",
        function()
          return vim.fmt(":IncRename %s", vim.fn.expand("<cword>"))
        end,
        expr = true,
        silent = false,
        desc = "lsp: incremental rename",
      },
    },
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    init = function()
      mrl.augroup("InlayHintsSetup", {
        event = "LspAttach",
        command = function(args)
          local id = vim.tbl_get(args, "data", "client_id") --[[@as lsp.Client]]
          if not id then
            return
          end
          local client = vim.lsp.get_client_by_id(id)
          require("lsp-inlayhints").on_attach(client, args.buf)
        end,
      })
    end,
    opts = {
      inlay_hints = {
        highlight = "Comment",
        labels_separator = " ⏐ ",
        parameter_hints = { prefix = "󰊕" },
        type_hints = { prefix = "=> ", remove_colon_start = true },
      },
    },
  },
  {
    "simrat39/rust-tools.nvim",
    dependencies = { "nvim-lspconfig" },
    ft = "rust",
  },
}
