return {
  {
    "https://codeberg.org/esensar/nvim-dev-container",
    dependencies = "nvim-treesitter/nvim-treesitter",
    commit = "462c9c296d65577ee6f0a9f326f5cce9b937eddf",
    opts = {},
    cmd = "DevContainer",
  },
  -- Tmux integraction {{{
  --
  -- {
  --     "otavioschwanck/tmux-awesome-manager.nvim",
  --     disable = true,
  --     config = function()
  --         require("tmux-awesome-manager").setup({
  --             per_project_commands = { -- Configure your per project servers with
  --                 -- project name = { { cmd, name } }
  --                 api = { { cmd = "rails server", name = "Rails Server" } },
  --                 front = { { cmd = "yarn dev", name = "react server" } },
  --             },
  --             session_name = "Neovim Terminals",
  --             use_icon = false, -- use prefix icon
  --             icon = " ", -- Prefix icon to use
  --             -- project_open_as = 'window', -- Open per_project_commands as.  Default: separated_session
  --             -- default_size = '30%', -- on panes, the default size
  --             -- open_new_as = 'window' -- open new command as.  options: pane, window, separated_session.
  --         })
  --     end,
  -- },
  --
  -- }}}
}

-- vim:foldmethod=marker
