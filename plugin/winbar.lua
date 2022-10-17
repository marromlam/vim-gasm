---@diagnostic disable: duplicate-doc-param


local highlights = require('luavim.core.highlights')
local utils = require('luavim.core.statusline')

local fn, api = vim.fn, vim.api
local component = utils.component
local component_raw = utils.component_raw
local empty = core.empty
local icons = core.style.icons.misc
local contains = vim.tbl_contains

local dir_separator = '/'
local separator = icons.arrow_right
local ellipsis = icons.ellipsis

--- A mapping of each winbar items ID to its path
--- @type table<string, string>
core.ui.winbar.state = {}

---@param id number
---@param _ number number of clicks
---@param _ "l"|"r"|"m" the button clicked
---@param _ string modifiers
function core.ui.winbar.click(id, _, _, _)
  if id then vim.cmd.edit(core.ui.winbar.state[id]) end
end

highlights.plugin('winbar', {
  { Winbar = { bold = false } },
  { WinbarNC = { bold = false } },
  { WinbarCrumb = { bold = true } },
  { WinbarIcon = { inherit = 'Function' } },
  { WinbarDirectory = { inherit = 'Directory' } },
})


local get_gps = function()
    local status_gps_ok, gps = pcall(require, "nvim-gps")
    if not status_gps_ok then
        return ""
    end

    local status_ok, gps_location = pcall(gps.get_location, {})
    if not status_ok then
        return ""
    end

    if not gps.is_available() or gps_location == "error" then
        return ""
    end

    if not require("luavim.core.functions2").isempty(gps_location) then
        return require("luavim.core.icons").ui.ChevronRight .. " " .. gps_location
    else
        return ""
    end
end

local function breadcrumbs()
  local location = get_gps()
  local win = api.nvim_get_current_win()
  return { component_raw(location, { priority = 1, win_id = win, type = 'winbar' }) }
end

---@return string
function core.ui.winbar.get()
  local winbar = {}
  local add = utils.winline(winbar)

  add(utils.spacer(1))

  local bufname = api.nvim_buf_get_name(api.nvim_get_current_buf())
  if empty(bufname) then return add(component('[No name]', 'Winbar', { priority = 0 })) end

  local parts = vim.split(fn.fnamemodify(bufname, ':.'), '/')

  core.foreach(function(part, index)
    local priority = (#parts - (index - 1)) * 2
    local is_last = index == #parts
    local sep = is_last and separator or dir_separator
    local hl = is_last and 'Winbar' or 'NonText'
    local suffix_hl = is_last and 'WinbarDirectory' or 'NonText'
    core.ui.winbar.state[priority] = table.concat(vim.list_slice(parts, 1, index), '/')
    add(component(part, hl, {
      id = priority,
      priority = priority,
      click = 'v:lua.core.ui.winbar.click',
      suffix = sep,
      suffix_color = suffix_hl,
    }))
  end, parts)
  add(unpack(breadcrumbs()))
  return utils.display(winbar, api.nvim_win_get_width(api.nvim_get_current_win()))
end

local blocked_fts = {
  'NeogitStatus',
  'DiffviewFiles',
  'NeogitCommitMessage',
  'toggleterm',
  'DressingInput',
  'org',
}

local allowed_fts = { 'toggleterm', 'neo-tree' }
local allowed_buftypes = { 'terminal' }

local function set_winbar()
  core.foreach(function(w)
    local buf, win = vim.bo[api.nvim_win_get_buf(w)], vim.wo[w]
    local bt, ft, is_diff = buf.buftype, buf.filetype, win.diff
    local ignored = contains(allowed_fts, ft) or contains(allowed_buftypes, bt)
    if not ignored then
      if
        not contains(blocked_fts, ft)
        and fn.win_gettype(api.nvim_win_get_number(w)) == ''
        and bt == ''
        and ft ~= ''
        and not is_diff
      then
        win.winbar = '%{%v:lua.core.ui.winbar.get()%}'
      elseif is_diff then
        win.winbar = nil
      end
    end
  end, api.nvim_tabpage_list_wins(0))
end

core.augroup('AttachWinbar', {
  {
    event = { 'BufWinEnter', 'TabNew', 'TabEnter', 'BufEnter', 'WinClosed' },
    desc = 'Toggle winbar',
    command = set_winbar,
  },
  {
    event = 'User',
    pattern = { 'DiffviewDiffBufRead', 'DiffviewDiffBufWinEnter' },
    desc = 'Toggle winbar',
    command = set_winbar,
  },
})
