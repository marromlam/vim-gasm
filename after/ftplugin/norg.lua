if not vim6 then return end

vim6.ftplugin_conf({
  cmp = function(cmp)
    cmp.setup.filetype("norg", {
      sources = cmp.config.sources({
        { name = "neorg" },
        { name = "dictionary" },
        { name = "spell" },
        { name = "emoji" },
      }, {
        { name = "buffer" },
      }),
    })
  end,
  ["nvim-surround"] = function(surround)
    surround.buffer_setup({
      surrounds = {
        l = {
          add = function()
            return {
              { "[" },
              { "]{" .. vim.fn.getreg("*") .. "}" },
            }
          end,
        },
      },
    })
  end,
})
