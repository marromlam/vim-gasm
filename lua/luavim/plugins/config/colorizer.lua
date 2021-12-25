local M = {}


M.config = function()
  local present, colorizer = pcall(require, "colorizer")
  if present then
     colorizer.setup({ "*" }, {
        RGB = true,                                           -- #RGB hex codes
        RRGGBB = true,                                     -- #RRGGBB hex codes
        names = false,                                -- "Name" codes like Blue
        RRGGBBAA = false,                                -- #RRGGBBAA hex codes
        rgb_fn = false,                       -- CSS rgb() and rgba() functions
        hsl_fn = false,                       -- CSS hsl() and hsla() functions
        css = false,                                 -- enable all CSS features
        css_fn = false,                             -- enable all CSS functions
        mode = "background",  -- set the display mode (foreground / background)
     })
     vim.cmd "ColorizerReloadAllBuffers"
  end
end


return M


-- vim:foldmethod=marker
