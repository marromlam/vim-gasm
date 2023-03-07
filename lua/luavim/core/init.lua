local fn = vim.fn
local api = vim.api
local fmt = string.format
local l = vim.log.levels


-- Global namespace {{{

_G.__core_global_callbacks = __core_global_callbacks or {}

_G.core = {
    _store = __core_global_callbacks,
    --- work around to place functions in the global scope but namespaced within a table.
    --- TODO: refactor this once nvim allows passing lua functions to mappings
    mappings = {},
    ui = {
        winbar = { enable = true },
        foldtext = { enable = false },
    },
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
    --[[ style = {}, ]]
}

-- }}}

-- Define some core functions {{{


--- Convert a list or map of items into a value by iterating all it's fields and transforming
--- them with a callback
---@generic T : table
---@param callback fun(T, T, key: string | number): T
---@param list T[]
---@param accum T?
---@return T
function core.fold(callback, list, accum)
    accum = accum or {}
    for k, v in pairs(list) do
        accum = callback(accum, v, k)
        assert(accum ~= nil, 'The accumulator must be returned on each iteration')
    end
    return accum
end


---Check if a cmd is executable
---@param e string
---@return boolean
function core.executable(e) return fn.executable(e) > 0 end

---@generic T : table
---@param callback fun(item: T, key: string | number, list: T[]): T
---@param list T[]
---@return T[]
function core.map_callback(callback, list)
    return core.fold(function(accum, v, k)
        accum[#accum + 1] = callback(v, k, accum)
        return accum
    end, list, {})
end

--
---Require a module using `pcall` and report any errors
---@param module string
---@param opts table?
---@return boolean, any
function core.require(module, opts)
    opts = opts or { silent = false }
    local ok, result = pcall(require, module)
    if not ok and not opts.silent then
        if opts.message then result = opts.message .. '\n' .. result end
        vim.notify(result, l.ERROR, { title = fmt('Error requiring: %s', module) })
    end
    return ok, result
end

---@generic T : table
---@param callback fun(T, key: string | number): T
---@param list T[]
function core.foreach(callback, list)
    for k, v in pairs(list) do
        callback(v, k)
    end
end

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

---Create an nvim command
---@param name any
---@param rhs string|fun(args: CommandArgs)
---@param opts table?
function core.new_command(name, rhs, opts)
    opts = opts or {}
    api.nvim_create_user_command(name, rhs, opts)
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

--- Validate the keys passed to as.augroup are valid
---@param name string
---@param cmd Autocommand
local function validate_autocmd(name, cmd)
    local keys = { 'event', 'buffer', 'pattern', 'desc', 'command', 'group', 'once', 'nested' }
    local incorrect = core.fold(function(accum, _, key)
        if not vim.tbl_contains(keys, key) then table.insert(accum, key) end
        return accum
    end, cmd, {})
    if #incorrect == 0 then return end
    vim.schedule(
        function()
            vim.notify('Incorrect keys: ' .. table.concat(incorrect, ', '), 'error', {
                title = fmt('Autocmd: %s', name),
            })
        end
    )
end

---Create an autocommand
---returns the group ID so that it can be cleared or manipulated.
---@param name string
---@param commands Autocommand[]
---@return number
function core.augroup(name, commands)
    assert(name ~= 'User', 'The name of an augroup CANNOT be User')
    assert(#commands > 0, fmt('You must specify at least one autocommand for %s', name))
    local id = api.nvim_create_augroup(name, { clear = true })
    for _, autocmd in ipairs(commands) do
        validate_autocmd(name, autocmd)
        local is_callback = type(autocmd.command) == 'function'
        api.nvim_create_autocmd(autocmd.event, {
            group = name,
            pattern = autocmd.pattern,
            desc = autocmd.desc,
            callback = is_callback and autocmd.command or nil,
            command = not is_callback and autocmd.command or nil,
            once = autocmd.once,
            nested = autocmd.nested,
            buffer = autocmd.buffer,
        })
    end
    return id
end

--- Call the given function and use `vim.notify` to notify of any errors
--- this function is a wrapper around `xpcall` which allows having a single
--- error handler for all errors
---@param msg string
---@param func function
---@vararg any
---@return boolean, any
---@overload fun(fun: function, ...): boolean, any
function core.wrap_err(msg, func, ...)
    local args = { ... }
    if type(msg) == 'function' then
        args, func, msg = { func, unpack(args) }, msg, nil
    end
    return xpcall(func, function(err)
        msg = msg and fmt('%s:\n%s', msg, err) or err
        --[[ vim.schedule(function() vim.notify(msg, l.ERROR, { title = 'ERROR' }) end) ]]
        vim.schedule(function() print(msg) end)
    end, unpack(args))
end

function core.empty(item)
    if not item then return true end
    local item_type = type(item)
    if item_type == 'string' then return item == '' end
    if item_type == 'number' then return item <= 0 end
    if item_type == 'table' then return vim.tbl_isempty(item) end
    return item ~= nil
end

---Find an item in a list
---@generic T
---@param matcher fun(arg: T):boolean
---@param haystack T[]
---@return T
function core.find(matcher, haystack)
    local found
    for _, needle in ipairs(haystack) do
        if matcher(needle) then
            found = needle
            break
        end
    end
    return found
end

-- }}}

-- Include some core files {{{

require "luavim.core.settings"
require "luavim.core.mapper"
require "luavim.core.mappings"
require "luavim.core.functions"
require "luavim.core.styles"

-- if not vim.g.has_gui then
--     require "luavim.core.winbar"
-- end
require "luavim.core.statusline"

-- }}}

-- vim:foldmethod=marker
