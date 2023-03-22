local opt, highlight = vim.opt_local, vim6.highlight

opt.list = false
opt.spelllang = "en_gb"

-- Schedule this call as highlights are not set correctly if there is not a delay
vim.schedule(function() highlight.set_winhl("gitcommit", 0, { { VirtColumn = { fg = { from = "Variable" } } } }) end)

if vim.treesitter.language.register then vim.treesitter.language.register("gitcommit", "NeogitCommitMessage") end

if not vim6 then return end
vim6.ftplugin_conf({
  cmp = function(cmp)
    cmp.setup.filetype("NeogitCommitMessage", {
      sources = cmp.config.sources({
        { name = "git" },
        { name = "luasnip" },
        { name = "dictionary" },
        { name = "spell" },
      }, {
        { name = "buffer" },
      }),
    })
  end,
})
