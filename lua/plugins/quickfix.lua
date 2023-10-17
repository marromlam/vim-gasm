-- Quickfix
-- ...
--

return {
  {
    url = "https://gitlab.com/yorickpeterse/nvim-pqf",
    event = "VeryLazy",
    -- config = function()
    --     highlight.plugin("pqf", {
    --         theme = {
    --             ["doom-one"] = { { qfPosition = { link = "Todo" } } },
    --             ["horizon"] = { { qfPosition = { link = "String" } } },
    --         },
    --     })
    --     require("pqf").setup()
    -- end,
  },
  {
    "kevinhwang91/nvim-bqf",
    -- event = "QuickFixCmdPre",
    ft = "qf",
    -- config = function()
    --     highlight.plugin(
    --         "bqf",
    --         { { BqfPreviewBorder = { fg = { from = "Comment" } } } }
    --     )
    -- end,
  },
  --  {
  --     -- TODO : make shure this works properly
  --     "ojroques/vim-oscyank",
  --     disable = false,
  --     keys = "<leader>y",
  --     config = function()
  --         vim.cmd [[
  --   vnoremap <leader>y :OSCYank<CR>
  --   nmap <leader>y <Plug>OSCYank
  --   ]]
  --     end,
  -- }
  -- {
  --   "ethanholz/nvim-lastplace",
  --   disable = false,
  --   -- event = "BufWinEnter",
  --   config = function()
  --     require("nvim-lastplace").setup({
  --       lastplace_ignore_buftype = { "alpha", "quickfix", "nofile", "help" },
  --       lastplace_ignore_filetype = {
  --         "gitcommit",
  --         "gitrebase",
  --         "svn",
  --         "hgcommit",
  --       },
  --       lastplace_open_folds = true,
  --     })
  --   end,
  -- },
  { "motosir/skel-nvim", event = "BufNewFile" },
  -- {
  --   "noahfrederick/vim-skeleton",
  --   event = "BufNewFile",
  --   config = function()
  --     vim.g.skeleton_template_dir = vim.fn.expand("~/.config/nvim")
  --       .. "/templates"
  --     vim.cmd([[
  --       let g:skeleton_replacements = {}
  --       function! g:skeleton_replacements.TITLE()
  --         return toupper(expand("%:t:r"))
  --       endfunction
  --     ]])
  --   end,
  -- },
}

-- vim: foldmethod=marker
