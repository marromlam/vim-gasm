local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " ", info = " " },
  colored = false,
  update_in_insert = false,
  always_visible = true,
  cond = hide_in_width,
}

local current_path = {
  "current_path",
  fmt = function()
    return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  end,
  icon = "",
  colored = false,
  cond = hide_in_width,
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " },
  cond = hide_in_width,
}

local filename = {
  "filename",
  fmt = function()
    return vim.fn.expand "%:t"
  end,
}

local filetype = {
  "filetype",
  icons_enabled = true,
  colored = false,
  -- icon = nil,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "", -- e0a0
}

local location = {
  "location",
  icon = "",
}

local progress = function()
  local current_line = vim.fn.line "."
  local total_lines = vim.fn.line "$"
  -- local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  -- local chars = { "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local chars = { "██", "▇▇", "▆▆", "▅▅", "▄▄", "▃▃", "▂▂", "▁▁", "▁▁" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

local spaces = function()
  return "sp: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local function lsp_progress(_, is_active)
  if not is_active then
    return
  end
  local messages = vim.lsp.util.get_progress_messages()
  if #messages == 0 then
    return ""
  end
  local status = {}
  for _, msg in pairs(messages) do
    local title = ""
    if msg.title then
      title = msg.title
    end
    table.insert(status, (msg.percentage or 0) .. "%% " .. title)
  end
  local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  return table.concat(status, "  ") .. " " .. spinners[frame + 1]
end

local function lsp_client()
  local msg = "No Active Lsp"
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return msg
  end
  local client_names = {}
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      client_names[client.name] = true
    end
  end
  if next(client_names) then
    local names = ""
    for k, _ in pairs(client_names) do
      if names == "" then
        names = k
      else
        names = names .. "," .. k
      end
    end
    return names
  end
  return msg
end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard", "Telescope", "Packer", "NvimTree", "Outline" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { branch, diff },
    lualine_b = { current_path },
    lualine_c = {
      filename,
      -- spaces,
      lsp_progress,
      -- { lsp_client, icon = " ", color = { fg = colors.violet, gui = "bold" } },
      -- { lsp_progress },
      -- {
      --   gps.get_location,
      --   cond = gps.is_available,
      --   color = { fg = colors.green },
      -- },
    },
    lualine_x = { { lsp_client, icon = " " }, { spaces } },
    lualine_y = { filetype, diagnostics },
    lualine_z = { location },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = { current_path },
    lualine_c = { filename },
    lualine_x = { location },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { "quickfix", "fugitive" },
}
