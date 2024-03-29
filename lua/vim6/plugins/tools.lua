return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim", "null-ls.nvim" },
    config = function()
      require("mason-null-ls").setup({
        automatic_setup = true,
        automatic_installation = {},
        ensure_installed = { "buf", "goimports", "golangci_lint", "stylua", "prettier" },
      })
      require("null-ls").setup({
        on_init = function(new_client, _) new_client.offset_encoding = "utf-16" end,
      })
      require("mason-null-ls").setup_handlers()
    end,
  },
}
