local M = {}

M.config = function()
   local present, lspkind = pcall(require, "lspkind")
   if present then
      lspkind.init()
   end
end

return M
