local M = {}


M.config = function()
  local status_ok, terminal = pcall(require, "toggleterm")
  if not status_ok then
    return
  end

  terminal.setup  {
    -- size can be a number or function which is passed the current terminal
    size = function(term)
      if term.direction == 'horizontal' then
        return 15
      elseif term.direction == 'vertical' then
        return math.floor(vim.o.columns * 0.4)
      end
    end,
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
    direction = "horizontal",
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

end


M.setup = function()
  local status_ok, toggleterm = pcall(require, "toggleterm")
  if not status_ok then
    return
  end

  local float_handler = function(term)
    if vim.fn.mapcheck('jk', 't') ~= '' then
      vim.api.nvim_buf_del_keymap(term.bufnr, 't', 'jk')
      vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<esc>')
    end
  end

  local Terminal = require('toggleterm.terminal').Terminal

  local lazygit = Terminal:new {
    cmd = 'lazygit',
    dir = 'git_dir',
    hidden = true,
    direction = 'float',
    on_open = float_handler,
  }

  local htop = Terminal:new {
    cmd = 'htop',
    hidden = 'true',
    direction = 'float',
    on_open = float_handler,
  }

  local Path = require 'plenary.path'
  local path = vim.fn.tempname()
  
  local vifm = Terminal:new {
    cmd = ('vifm --choose-files "%s"'):format(path),
    -- direction = "float",
    close_on_exit = true,
    on_close = function()
      data = Path:new(path):read()
      vim.schedule(function()
        vim.cmd('e ' .. data)
      end)
    end
  }

  core.command {
    'Htop',
    function() htop:toggle() end,
  }

  core.command {
    'Lazygit',
    function() lazygit:toggle() end,
  }

  core.command {
    'Vifm',
    function() vifm:toggle() end,
  }

  core.map({'n'}, "<leader>gg",
    function() lazygit:toggle() end,
    "Lazygit"
  )

  core.map({'n'}, "<leader>e",
    function() vifm:toggle() end,
    "Lazygit"
  )

end

return M
