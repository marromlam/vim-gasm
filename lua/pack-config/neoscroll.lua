local M = {}

M.config = function()
   pcall(function()
      require("neoscroll").setup()
   end)
end

return M
