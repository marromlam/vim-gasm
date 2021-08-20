local M = {}


M.setup = function()
  local present, chadsheet = pcall(require, "cheatsheet")
  if not present then
     return
  end
  
  require("cheatsheet").setup {
    bundled_cheatsheets = {
      enabled = { "default" },
      disabled = { "unicode", "nerd-fonts" },
    },
  
    bundled_plugin_cheatsheets = false,
    include_only_installed_plugins = true,
  }
end


return M
