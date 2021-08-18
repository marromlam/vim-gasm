local g = vim.g
local fn = vim.fn

local plugins_count = fn.len(fn.globpath("~/.local/share/nvim/site/pack/packer/start", "*", 0, 1))

-- g.dashboard_disable_at_vimenter = 0 -- dashboard is disabled by default
g.dashboard_disable_statusline = 1
g.dashboard_default_executive = "telescope"
g.dashboard_custom_header = {
  "                                                      ",
  "                                                      ",
  "                                                      ",
  "                                                      ",
  "                                        ▟▙            ",
  "                                        ▝▘            ",
  "██▃▅▇█▆▖  ▗▟████▙▖   ▄████▄   ██▄  ▄██  ██  ▗▟█▆▄▄▆█▙▖",
  "██▛▔ ▝██  ██▄▄▄▄██  ██▛▔▔▜██  ▝██  ██▘  ██  ██▛▜██▛▜██",
  "██    ██  ██▀▀▀▀▀▘  ██▖  ▗██   ▜█▙▟█▛   ██  ██  ██  ██",
  "██    ██  ▜█▙▄▄▄▟▊  ▀██▙▟██▀   ▝████▘   ██  ██  ██  ██",
  "▀▀    ▀▀   ▝▀▀▀▀▀     ▀▀▀▀       ▀▀     ▀▀  ▀▀  ▀▀  ▀▀",
  "                                                      ",
  "                                                      ",
}

g.dashboard_custom_section = {
    a = {description = {"  Find File        "}, command = "Telescope find_files"},
    b = {description = {"  Recents          "}, command = "Telescope oldfiles"},
    c = {description = {"  Find Word        "}, command = "Telescope live_grep"},
    d = {description = {"洛 New File         "}, command = "DashboardNewFile"},
    e = {description = {"  Bookmarks        "}, command = "Telescope marks"},
    f = {description = {"  Load Last Session"}, command = "SessionLoad"}
}

g.dashboard_custom_footer = {
    "   ",
    "With <3 in Santiago by Marcosito",
    "Launched " .. plugins_count .. " plugins",
} 


require("pack-config.autocmds").define_augroups {
  _dashboard = {
    -- seems to be nobuflisted that makes my stuff disapear will do more testing
    {
      "FileType",
      "dashboard",
      "setlocal nocursorline noswapfile synmaxcol& signcolumn=no norelativenumber nocursorcolumn nospell  nolist  nonumber bufhidden=wipe colorcolumn= foldcolumn=0 matchpairs= ",
    },
    {
      "FileType",
      "dashboard",
      "set showtabline=0 | autocmd BufLeave <buffer> set showtabline=" .. vim.opt.showtabline._value,
    },
    { "FileType", "dashboard", "nnoremap <silent> <buffer> q :q<CR>" },
  },
}
