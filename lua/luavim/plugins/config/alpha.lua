local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end


local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {

  -- [[                                                      ]],
  -- [[                                                      ]],
  -- [[                                                      ]],
  [[                                                      ]],
  [[                                        ▟▙            ]],
  [[                                        ▝▘            ]],
  [[██▃▅▇█▆▖  ▗▟████▙▖   ▄████▄   ██▄  ▄██  ██  ▗▟█▆▄▄▆█▙▖]],
  [[██▛▔ ▝██  ██▄▄▄▄██  ██▛▔▔▜██  ▝██  ██▘  ██  ██▛▜██▛▜██]],
  [[██    ██  ██▀▀▀▀▀▘  ██▖  ▗██   ▜█▙▟█▛   ██  ██  ██  ██]],
  [[██    ██  ▜█▙▄▄▄▟▊  ▀██▙▟██▀   ▝████▘   ██  ██  ██  ██]],
  [[▀▀    ▀▀   ▝▀▀▀▀▀     ▀▀▀▀       ▀▀     ▀▀  ▀▀  ▀▀  ▀▀]],
  [[                                                      ]],
  [[                                                      ]],
  [[             anno uno ad neovim transitus             ]],
  [[                                                      ]],
}


-- define buttons
dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", "洛 New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
  dashboard.button("s", "  Load Last Session", ":SessionLoad <CR>"),
	dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
  dashboard.button("b", "  Bookmarks", ":Telescope marks <CR>"),
	dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
	dashboard.button("q", "  Quit", ":qa<CR>"),
}


-- create a footer function. This allows us to create fancy footers
-- like the one in vim-startify if we wish
local function footer()
  return "luavim loaded in " .. vim.fn.printf(
    "%.2f",
    1000 * vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time))
  ) .. " ms"
end


dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"


dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)


-- vim:foldmethod=marker
