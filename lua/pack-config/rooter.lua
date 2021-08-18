local M = {}
function M.config()
  nvim.builtin.rooter = {
    --- This is on by default since it's currently the expected behavior.
    ---@usage set to false to disable vim-rooter.
    active = true,
    silent_chdir = 1,
    manual_only = 0,
  }
end
function M.setup()
  vim.g.rooter_silent_chdir = nvim.builtin.rooter.silent_chdir
  vim.g.rooter_manual_only = nvim.builtin.rooter.manual_only
end
return M
