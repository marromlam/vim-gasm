local M = {}

M.config = function()
   local present, colorizer = pcall(require, "colorizer")
   if present then
      colorizer.setup()
      vim.cmd "ColorizerReloadAllBuffers"
   end
end

return M
