local opt = vim.opt
local g = vim.g


-- The basics {{{

opt.hidden = true
opt.wrap = false
opt.clipboard = "unnamedplus"

opt.termguicolors = true
opt.cul = true
opt.completeopt = { "menuone", "noselect" }
opt.conceallevel = 0            -- so that `` is visible in markdown files
opt.fileencoding = "utf-8"      -- the encoding written to a file
opt.pumheight = 10              -- pop up menu height
opt.foldmethod = "manual"       -- folding,set to "expr" for treesitter based folding
opt.foldexpr = ""               -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
opt.hlsearch = true             -- highlight all matches on previous search pattern
opt.cmdheight = 1               -- more space in the neovim command line for displaying messages
opt.mouse = "a"                 -- allow the mouse to be used in neovim

-- Splits default config
opt.splitbelow = true
opt.splitright = true

-- Always display status line
-- laststatus = 2

-- Line numbers
opt.number = true               -- set numbered lines
opt.relativenumber = true       -- set relative numbered lines
opt.numberwidth = 2             -- set number column width to 2 {default 4}

-- Enable highlighting or the current line
opt.cursorline = true           -- highlight the current line

-- We do not need -- INSERT     -- anymore
opt.showmode = false            -- we don't need to see things like -- INSERT -- anymore

-- Title
opt.title = true                -- set the title of window to the value of the titlestring
-- opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
opt.titlestring = "nvim"        -- what the title of the window will be set to

-- Enable undo persistence
opt.undodir = "~/.cache/undo"   -- set an undo directory
opt.undofile = true             -- enable persistent undo
opt.swapfile = false            -- creates a swapfile
opt.backup = false              -- creates a backup file
opt.writebackup = false         -- if a file is being edited by another program (or was written to file while editing with another program),it is not allowed to be edited

-- Disable nvim intro
opt.shortmess:append("sI")

-- Disable tilde on end of buffer
opt.fillchars = {eob = " "}


-- Set leader
g.mapleader = " "

-- Autosave
g.auto_save = true

-- }}}


-- Tabs and identations {{{

opt.tabstop = 2                 -- insert 2 spaces for a tab
opt.shiftwidth = 2              -- the number of spaces inserted for each indentation
opt.expandtab = true            -- convert tabs to spaces
opt.smartindent = true          -- make indenting smarter again
opt.showtabline = 2             -- always show tabs

-- }}}


-- hmm {{{

opt.signcolumn = "yes"          -- always show the sign column,otherwise it would shift the text each time
opt.updatetime = 300            -- faster completion
opt.timeoutlen = 1000           -- time to wait for a mapped sequence to complete (in milliseconds)

-- dictionary
opt.spelllang = "en"
opt.spell = false

-- }}}


-- New stuff {{{

opt.scrolloff = 8               -- is one of my fav
opt.sidescrolloff = 8
-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>hl")

-- }}}


-- Search {{{

opt.ignorecase = true           -- ignore case in search patterns
opt.smartcase = true            -- smart case

-- }}}


-- Disable builtin vim plugins {{{

local disabled_built_ins = {
    -- "netrw",
    -- "netrwPlugin",
    -- "netrwSettings",
    -- "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end

-- }}}


-- netrw config {{{

g.netrw_fastbrowse = 0

vim.cmd [[
" functions for file extension '.md'.
function! NFH_md(f)
    execute '!typora' a:f
endfunction

" functions for file extension '.pdf'.
function! NFH_pdf(f)
    execute '!zathura' a:f
endfunction
]]

-- }}}


-- Don't show status line on vim terminals
vim.cmd [[ au TermOpen term://* setlocal nonumber laststatus=0 ]]

-- Open a file from its last left off position
-- vim.cmd [[ au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]
-- File extension specific tabbing
-- vim.cmd [[ autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 ]]


-- vim:foldmethod=marker
