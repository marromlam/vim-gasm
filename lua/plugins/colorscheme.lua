return {
  -- add gruvbox
  -- { "ellisonleao/gruvbox.nvim" },
  --
  -- mini base 16
  {
    "echasnovski/mini.base16",
    branch = "stable",
  },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tomorrow",
    },
  },
}
