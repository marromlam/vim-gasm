-- Global namespace {{{

_G.__core_global_callbacks = __core_global_callbacks or {}

_G.core = {
  _store = __core_global_callbacks,
  --- work around to place functions in the global scope but namespaced within a table.
  --- TODO: refactor this once nvim allows passing lua functions to mappings
  mappings = {},
  plugins = {
    autopairs = false,
    base16 = true,
    blankline = true, -- show code scope with symbols
    bufferline = true, -- list open buffers up the top, easy switching too
    cmp = true,
    lsp = true,
    --
    -- colorizes rgb, hex and other color namespaces
    colorizer = true, -- color RGB, HEX, CSS, NAME color codes
    --
    -- comment code, language aware
    comment = true, -- easily (un)comment code, language aware
    --
    -- Homescreen with logo session loader ...
    dashboard = true, -- NeoVim 'home screen' on open
    esc_insertmode = true, -- map to <ESC> with no lag
    lualine = true, -- statusline
    lastplace = true,
    fugitive = true,
    gitsigns = true, -- gitsigns in statusline
    lspsignature = true, -- lsp enhancements
    telescope_media = false, -- media previews within telescope finders
    matchup = true, -- % operator enhancements
    vimtex = false,
    nvimtree = true,
    treesitter = true,
    telescope = true,
    trouble = false,
    osyank = true,
    snap = false,
    vinegar = true,
    -- Themes
    doom = false,
  },
  languages = { "py", "cpp", "hpp", "c", "h", "lua", "bash", "zsh", "tex", "rs" },
  -- lsp = {}
}

-- }}}

-- Define some core functions {{{

function core.deep_merge(t1, t2)
  for k, v in pairs(t2) do
    if (type(v) == "table") and (type(t1[k] or false) == "table") then
      core.deep_merge(t1[k], t2[k])
    else
      t1[k] = v
    end
  end
  return t1
end

function core._create(f)
  table.insert(core._store, f)
  return #core._store
end

function core._execute(id, args)
  core._store[id](args)
end

---Create an nvim command
---@param args table
function core.command(args)
  local nargs = args.nargs or 0
  local name = args[1]
  local rhs = args[2]
  local types = (args.types and type(args.types) == "table") and table.concat(args.types, " ") or ""

  if type(rhs) == "function" then
    local fn_id = core._create(rhs)
    rhs = string.format("lua core._execute(%d%s)", fn_id, nargs > 0 and ", <f-args>" or "")
  end

  vim.cmd(string.format("command! -nargs=%s %s %s %s", nargs, types, name, rhs))
end

-- load plugin after entering vim ui
function core.load_after_ui(plugin, delay)
  if plugin then
    delay = delay or 0
    vim.defer_fn(function()
      require("packer").loader(plugin)
    end, delay)
  end
end

-- }}}

-- Include some core files {{{

require "luavim.core.settings"
require "luavim.core.mapper"
require "luavim.core.mappings"
require "luavim.core.functions"
require "luavim.core.winbar"

-- }}}

-- vim:foldmethod=marker
