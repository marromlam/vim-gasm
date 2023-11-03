return {
  {
    "rcarriga/nvim-notify",
    config = function(_, opts)
      require("notify").setup(vim.tbl_extend("keep", {
        background_colour = mrl.get_hi("Normal", "bg"),
      }, opts))
    end,
  },
}
