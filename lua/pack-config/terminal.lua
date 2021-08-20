local M = {}


M.config = function()
  local status_ok, terminal = pcall(require, "toggleterm")
  if not status_ok then
    return
  end
  terminal.setup  {
    -- size can be a number or function which is passed the current terminal
    size = 5,
    -- open_mapping = [[<c-\>]],
    open_mapping = [[<c-t>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = true,
    -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
    direction = "float",
    -- direction = "horizontal",
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
      -- The border key is *almost* the same as 'nvim_win_open'
      -- see :h nvim_win_open for details on borders however
      -- the 'curved' border is a custom border type
      -- not natively supported but implemented in this plugin.
      -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
      border = "curved",
      -- width = <value>,
      -- height = <value>,
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
  }
  function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
  end
  --print(dump(terminal))
end


M.setup = function()
  local status_ok, terminal = pcall(require, "toggleterm")
  if not status_ok then
    print(terminal)
    return
  end
  -- Declare executables
  executables = {
    { "lazygit", "gg", "LazyGit" }
  }
  for _, exec in pairs(executables) do
    require("pack-config.terminal").add_exec(exec[1], exec[2], exec[3])
  end
end


local function is_installed(exe)
  return vim.fn.executable(exe) == 1
end

M.add_exec = function(exec, keymap, name)
  local status_ok, wk = pcall(require, "which-key")
  if not status_ok then
    print(terminal)
    return
  end
 
  wk.register(
    {
      ["gg"] = {
        "<cmd>lua require('pack-config.terminal')._exec_toggle('" .. exec .. "')<CR>",
        name 
      },
    },
    { 
      prefix = "<leader>",
      noremap = true,
      silent = true 
    }
  )

end

M._split = function(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

M._exec_toggle = function(exec)
  local binary = M._split(exec)[1]
  if is_installed(binary) ~= true then
    print("Please install executable " .. binary .. ". Check documentation for more information")
    return
  end
  local Terminal = require("toggleterm.terminal").Terminal
  local exec_term = Terminal:new { cmd = exec, hidden = true }
  exec_term:toggle()
end

return M
