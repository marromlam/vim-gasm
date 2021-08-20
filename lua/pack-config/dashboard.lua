local g = vim.g
local fn = vim.fn

local plugins_count = fn.len(fn.globpath("~/.local/share/nvim/site/pack/packer/start", "*", 0, 1))


g.dashboard_disable_at_vimenter = 0
g.dashboard_disable_statusline = 1
g.dashboard_default_executive = "telescope"
g.dashboard_custom_header = {
--  "                                                      ",
--  "                                                      ",
--  "                                                      ",
--  "                                                      ",
--  "                                        ▟▙            ",
--  "                                        ▝▘            ",
--  "██▃▅▇█▆▖  ▗▟████▙▖   ▄████▄   ██▄  ▄██  ██  ▗▟█▆▄▄▆█▙▖",
--  "██▛▔ ▝██  ██▄▄▄▄██  ██▛▔▔▜██  ▝██  ██▘  ██  ██▛▜██▛▜██",
--  "██    ██  ██▀▀▀▀▀▘  ██▖  ▗██   ▜█▙▟█▛   ██  ██  ██  ██",
--  "██    ██  ▜█▙▄▄▄▟▊  ▀██▙▟██▀   ▝████▘   ██  ██  ██  ██",
--  "▀▀    ▀▀   ▝▀▀▀▀▀     ▀▀▀▀       ▀▀     ▀▀  ▀▀  ▀▀  ▀▀",
--  "                                                      ",
"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣀",
"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣴⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣦⣤⣀⡀",
"⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣀",
"⠀⠀⠀⠀⠀⢀⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄",
"⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄",
"⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣟⠻⡻⢿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧",
"⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣟⢄⡀⠛⠛⣹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢿⣿⣿⡿⣿⣟⡥",
"⠀⣼⣿⣿⣿⣿⣿⡿⢟⣋⣙⠖⡀⠁⠂⠄⣠⣽⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣯⣟⣻⡻⠟⠮⠾⠁",
"⢰⣿⣿⣿⣿⣿⣿⣵⣬⣯⣠⡔⣳⢄⣔⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣿⡿⣿⣿⣽⣷⣿⠛⢛⢞⠳⠅⠀⠀⠁",
"⢸⣿⣿⣿⣿⣿⡟⠂⠀⠀⠀⠠⠃⣬⠈⠉⢿⣿⣿⣿⣽⣿⡥⠾⠻⡷⠃⠛⣉⠪⠉⡯⠛⠒⢍⠈",
"⢸⣿⣿⢿⣿⢿⣷⢸⣿⡇⠀⠈⠀⠀⠀⠀⠨⢉⠃⠁⠀⠨⠀⠀⠀⠊⠁⠀⠀⠀⠀⠀⠀⠿⠿",
"⠈⣿⡝⠊⠠⠟⠃⢸⣿⡇⢸⣿⡇⠀⠀⣿⣿⠀⢠⣶⡿⠿⢿⣶⡀⠘⣿⡇⠀⠀⣿⡟⠀⣿⣿⠀⢸⣿⡾⠿⣿⣷⡴⠿⣿⣷⡄",
"⠀⠉⠀⠀⠀⠃⠀⢸⣿⡇⢸⣿⡇⠀⠀⣿⣿⠀⢀⣭⡶⠶⢾⣿⡇⠀⢹⣷⠀⢰⣿⠁⠀⣿⣿⠀⢸⣿⡇⠀⢸⣿⡇⠀⢸⣿⡇",
"⠀⠀⠀⠀⠀⠀⠀⢸⣿⡇⠀⢿⣷⣤⣴⣿⣿⠀⢻⣿⣤⣤⢾⣿⡇⠀⠈⢿⣶⡾⠏⠀⠀⣿⣿⠀⢸⣿⡇⠀⢸⣿⡇⠀⢸⣿⡇",
"⠀⠀⠀⠀⠀⠀⠀⠈⠉⠁⠀⠀⠈⠉⠉⠁⠉⠀⠀⠉⠉⠁⠈⠉⠁⠀⠀⠀⠉⠀⠀⠀⠀⠉⠉⠀⠈⠉⠁⠀⠈⠉⠁⠀⠈⠉⠁",
"              with <3 in Santiago by Marcosito "
}

g.dashboard_custom_section = {
    a = {description = {"  Find File             spc r"}, command = "Telescope find_files"},
    b = {description = {"  Recents               spc r"}, command = "Telescope oldfiles"},
    c = {description = {"  Find Word             spc r"}, command = "Telescope live_grep"},
    d = {description = {"洛 New File              spc r"}, command = "DashboardNewFile"},
    e = {description = {"  Bookmarks             spc r"}, command = "Telescope marks"},
    f = {description = {"  Load Last Session     spc r"}, command = "SessionLoad"}
}

g.dashboard_custom_footer = {
    "Launched " .. plugins_count .. " plugins"
}
