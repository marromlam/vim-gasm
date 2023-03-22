---@diagnostic disable: duplicate-doc-param

if not vim6 or not vim6.ui.winbar.enable then return end

local str = require('vim6.strings')
local decorations = vim6.ui.decorations

local fn, api = vim.fn, vim.api
local component = str.component
local component_raw = str.component_raw
local empty = vim6.empty
local icons = vim6.ui.icons.misc

local dir_separator = '/'
local separator = icons.arrow_right
local ellipsis = icons.ellipsis

--- A mapping of each winbar items ID to its path
--- @type table<string, string>
vim6.ui.winbar.state = {}

---@param id number
---@param _ number number of clicks
---@param _ "l"|"r"|"m" the button clicked
---@param _ string modifiers
function vim6.ui.winbar.click(id, _, _, _)
  if id then vim.cmd.edit(vim6.ui.winbar.state[id]) end
end

vim6.highlight.plugin('winbar', {
  { Winbar = { bold = false } },
  { WinbarNC = { bold = false } },
  { WinbarCrumb = { bold = true } },
  { WinbarIcon = { inherit = 'Function' } },
  { WinbarDirectory = { inherit = 'Directory' } },
})

local function breadcrumbs()
  local ok, navic = pcall(require, 'nvim-navic')
  local empty_state = { component(ellipsis, 'NonText', { priority = 0 }) }
  if not ok or not navic.is_available() then return empty_state end
  local navic_ok, location = pcall(navic.get_location)
  if not navic_ok or empty(location) then return empty_state end
  local win = api.nvim_get_current_win()
  return { component_raw(location, { priority = 1, win_id = win, type = 'winbar' }) }
end

---@return string
function vim6.ui.winbar.get()
  local winbar = {}
  local add = str.winline(winbar)

  add(str.spacer(1))

  local bufname = api.nvim_buf_get_name(api.nvim_get_current_buf())
  if empty(bufname) then return add(component('[No name]', 'Winbar', { priority = 0 })) end

  local parts = vim.split(fn.fnamemodify(bufname, ':.'), '/')

  vim6.foreach(function(part, index)
    local priority = (#parts - (index - 1)) * 2
    local is_last = index == #parts
    local sep = is_last and separator or dir_separator
    local hl = is_last and 'Winbar' or 'NonText'
    local suffix_hl = is_last and 'WinbarDirectory' or 'NonText'
    vim6.ui.winbar.state[priority] = table.concat(vim.list_slice(parts, 1, index), '/')
    add(component(part, hl, {
      id = priority,
      priority = priority,
      click = 'v:lua.vim6.ui.winbar.click',
      suffix = sep,
      suffix_color = suffix_hl,
    }))
  end, parts)
  add(unpack(breadcrumbs()))
  return str.display(winbar, api.nvim_win_get_width(api.nvim_get_current_win()))
end

local function set_winbar()
  vim6.foreach(function(w)
    local buf, win = vim.bo[api.nvim_win_get_buf(w)], vim.wo[w]
    local bt, ft, is_diff = buf.buftype, buf.filetype, win.diff
    local ft_setting = decorations.get(ft, 'winbar', 'ft')
    local bt_setting = decorations.get(bt, 'winbar', 'bt')
    local ignored = ft_setting == 'ignore' or bt_setting == 'ignore'
    if not ignored then
      if
        not ft_setting
        and fn.win_gettype(api.nvim_win_get_number(w)) == ''
        and bt == ''
        and ft ~= ''
        and not is_diff
      then
        win.winbar = '%{%v:lua.vim6.ui.winbar.get()%}'
      elseif is_diff then
        win.winbar = nil
      end
    end
  end, api.nvim_tabpage_list_wins(0))
end

vim6.augroup('AttachWinbar', {
  event = { 'BufWinEnter', 'TabNew', 'TabEnter', 'BufEnter', 'WinClosed' },
  desc = 'Toggle winbar',
  command = set_winbar,
}, {
  event = 'User',
  pattern = { 'DiffviewDiffBufRead', 'DiffviewDiffBufWinEnter' },
  desc = 'Toggle winbar',
  command = set_winbar,
})
