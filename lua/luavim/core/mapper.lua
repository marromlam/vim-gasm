local api = vim.api
local fmt = string.format

---check if a mapping already exists
---@param lhs string
---@param mode string
---@return boolean
function core.has_map(lhs, mode)
  mode = mode or 'n'
  return vim.fn.maparg(lhs, mode) ~= ''
end

---create a mapping function factory
---@param mode string
---@param o table
---@return fun(lhs: string, rhs: string, opts: table|nil) 'create a mapping'
local function make_mapper(mode, o)
  -- copy the opts table as extends will mutate the opts table passed in otherwise
  local parent_opts = vim.deepcopy(o)
  ---Create a mapping
  ---@param lhs string
  ---@param rhs string|function
  ---@param opts table
  return function(lhs, rhs, opts)
    assert(lhs ~= mode, fmt('The lhs should not be the same as mode for %s', lhs))
    assert(type(rhs) == 'string' or type(rhs) == 'function', '"rhs" should be a function or string')
    -- If the label is all that was passed in, set the opts automagically
    opts = type(opts) == 'string' and { label = opts } or opts and vim.deepcopy(opts) or {}

    local buffer = opts.buffer
    opts.buffer = nil
    if type(rhs) == 'function' then
      local fn_id = core._create(rhs)
      rhs = string.format('<cmd>lua core._execute(%s)<CR>', fn_id)
    end

    if opts.label then
      local ok, wk = pcall(require, 'which-key')
      if ok then
        wk.register({ [lhs] = opts.label }, { mode = mode })
      end
      opts.label = nil
    end

    opts = vim.tbl_extend('keep', opts, parent_opts)
    if buffer and type(buffer) == 'number' then
      return api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts)
    end

    api.nvim_set_keymap(mode, lhs, rhs, opts)
  end
end

local map_opts = { noremap = false, silent = true }
local noremap_opts = { noremap = true, silent = true }

-- A recursive commandline mapping
core.nmap = make_mapper('n', map_opts)
-- A recursive select mapping
core.xmap = make_mapper('x', map_opts)
-- A recursive terminal mapping
core.imap = make_mapper('i', map_opts)
-- A recursive operator mapping
core.vmap = make_mapper('v', map_opts)
-- A recursive insert mapping
core.omap = make_mapper('o', map_opts)
-- A recursive visual & select mapping
core.tmap = make_mapper('t', map_opts)
-- A recursive visual mapping
core.smap = make_mapper('s', map_opts)
-- A recursive normal mapping
core.cmap = make_mapper('c', { noremap = false, silent = false })
-- A non recursive normal mapping
core.nnoremap = make_mapper('n', noremap_opts)
-- A non recursive visual mapping
core.xnoremap = make_mapper('x', noremap_opts)
-- A non recursive visual & select mapping
core.vnoremap = make_mapper('v', noremap_opts)
-- A non recursive insert mapping
core.inoremap = make_mapper('i', noremap_opts)
-- A non recursive operator mapping
core.onoremap = make_mapper('o', noremap_opts)
-- A non recursive terminal mapping
core.tnoremap = make_mapper('t', noremap_opts)
-- A non recursive select mapping
core.snoremap = make_mapper('s', noremap_opts)
-- A non recursive commandline mapping
core.cnoremap = make_mapper('c', { noremap = true, silent = false })

---Factory function to create multi mode map functions
---e.g. `core.map({"n", "s"}, lhs, rhs, opts)`
---@param target string
---@return fun(modes: string[], lhs: string, rhs: string, opts: table)
local function multimap(target)
  return function(modes, lhs, rhs, opts)
    for _, m in ipairs(modes) do
      core[m .. target](lhs, rhs, opts)
    end
  end
end

---Luavim standard mapper function
---e.g. `core.map({"n"}, "<leader>", "<cmd>Telescove find_files", "Search files")`
---@param target string
---@return fun(modes: string[], lhs: string, rhs: string, opts: table)
core.map = multimap 'map'
---Luavim noremapper function
---e.g. `core.nomap({"n"}, "<leader>", "<cmd>Telescove find_files", "Search files")`
---@param target string
---@return fun(modes: string[], lhs: string, rhs: string, opts: table)
core.noremap = multimap 'noremap'


-- vim:foldmethod=marker
