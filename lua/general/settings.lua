local M = {}


-- Settings {{{

M.load_options = function()
  local opt = vim.opt

  local default_options = {

    -- The basics {{{

    -- iskeyword = +=-,
    -- formatoptions = -=cro,
    --
    --
    hidden = true, -- required to keep multiple buffers and open multiple buffers
    wrap = false, -- display lines as one long line
    -- clipboard = "unnamedplus", -- allows neovim to access the system clipboard
    colorcolumn = "99999", -- fixes indentline for now
    completeopt = { "menuone", "noselect" },
    conceallevel = 0, -- so that `` is visible in markdown files
    fileencoding = "utf-8", -- the encoding written to a file
    pumheight = 10, -- pop up menu height
    foldmethod = "manual", -- folding, set to "expr" for treesitter based folding
    foldexpr = "", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
    -- guifont = "monospace:h17", -- the font used in graphical neovim applications
    hlsearch = true, -- highlight all matches on previous search pattern
    cmdheight = 1, -- more space in the neovim command line for displaying messages
    mouse = "a", -- allow the mouse to be used in neovim

    -- Splits default config
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window

    -- Always display status line
    -- laststatus = 2

    -- Line numbers
    number = true, -- set numbered lines
    relativenumber = true, -- set relative numbered lines
    numberwidth = 4, -- set number column width to 2 {default 4}

    -- Enable highlighting or the current line
    cursorline = true, -- highlight the current line

    -- We do not need -- INSERT -- anymore
    showmode = false, -- we don't need to see things like -- INSERT -- anymore


    swapfile = false, -- creates a swapfile
    title = true, -- set the title of window to the value of the titlestring
    -- opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
    titlestring = "nvim", -- what the title of the window will be set to

    -- Enabke undo persistence
    undodir = CACHE_PATH .. "/undo", -- set an undo directory
    undofile = true, -- enable persistent undo

    -- }}}


    -- Tabs and identations {{{

    tabstop = 2, -- insert 2 spaces for a tab
    shiftwidth = 2, -- the number of spaces inserted for each indentation
    expandtab = true, -- convert tabs to spaces
    smartindent = true, -- make indenting smarter again
    showtabline = 2, -- always show tabs

    -- }}}


    -- Backup {{{

    -- This is recommendend by CoC...
    backup = false, -- creates a backup file
    writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

    -- }}}


    -- hmm {{{

    signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
    updatetime = 300, -- faster completion
    timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)

    -- dictionary
    spelllang = "en",
    spell = false,

    -- }}}


    -- New stuff {{{

    scrolloff = 8, -- is one of my fav
    sidescrolloff = 8,

    -- }}}


    -- Search {{{
    ignorecase = true, -- ignore case in search patterns
    smartcase = true, -- smart case
    -- }}}

  }


  --  VIM ONLY COMMANDS
  -- cmd "filetype plugin on"cmd('let &titleold="' .. TERMINAL .. '"')cmd "set inccommand=split"cmd "set iskeyword+=-"


  -- Settings {{{

  opt.shortmess:append "c"
  opt.clipboard:append "unnamedplus"
  opt.iskeyword:append "-"
  -- opt.formatoptions = -=cro,

  -- }}}

  for k, v in pairs(default_options) do
    vim.opt[k] = v
  end

end

-- }}}


-- Load commands {{{

M.load_commands = function()
  local cmd = vim.cmd
  if nvim.line_wrap_cursor_movement then
    cmd "set whichwrap+=<,>,[,],h,l"
  end
end

-- }}}

return M


-- vim:foldmethod=marker
