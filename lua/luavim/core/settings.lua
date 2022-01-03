--bottom General settings


-- Vim messages on vim actions {{{

-- vim.opt.shortmess = {
--  t = true, -- truncate file messages at start
--  A = true, -- ignore annoying swap file messages
--  o = true, -- file-read message overwrites previous
--  O = true, -- file-read message overwrites previous
--  T = true, -- truncate non-file messages in middle
--  f = true, -- (file x of x) instead of just (x of x
--  F = true, -- Don't give file info when editing a file, NOTE: this breaks autocommand messages
--  sI = true,
--  c = true,
--  W = true, -- Don't show [w] or written when writing
-- }
vim.opt.shortmess:append("sI")
vim.opt.shortmess:append("c")

-- }}}

-- Timings {{{

vim.opt.updatetime = 300     -- faster completion
vim.opt.timeout = true
vim.opt.timeoutlen = 200     -- time to wait for a mapped sequence to complete
vim.opt.ttimeoutlen = 10

-- }}}

-- Window and buffer managers {{{

vim.opt.hidden = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.eadirection = 'hor' -- TODO what is this?

-- exclude usetab as we do not want to jump to buffers in already open tabs
-- do not use split or vsplit to ensure we don't open any new windows
vim.o.switchbuf = 'useopen,uselast'
vim.opt.fillchars = {
  vert = '▕',                                      -- alternatives │
  fold = ' ',
  eob = ' ',                                       -- suppress ~ at EndOfBuffer
  diff = '╱',                                      -- alternatives = ⣿ ░ ─
  msgsep = '‾',
  foldopen = '▾',
  foldsep = '│',
  foldclose = '▸',
}

-- }}}

-- Diff options {{{

vim.opt.diffopt = vim.opt.diffopt
  + {
    'vertical',
    'iwhite',
    'hiddenoff',
    'foldcolumn:0',
    'context:4',
    'algorithm:histogram',
    'indent-heuristic',
  }

-- }}}

-- Format Options {{{

-- Options {{{

vim.opt.formatoptions = {
  ['1'] = true,
  ['2'] = true, -- Use indent from 2nd line of a paragraph
  q = true, -- continue comments with gq"
  c = true, -- Auto-wrap comments using textwidth
  r = true, -- Continue comments when pressing Enter
  n = true, -- Recognize numbered lists
  t = false, -- autowrap lines using text width value
  j = true, -- remove a comment leader when joining lines.
  -- Only break if the line was not longer than 'textwidth' when the insert
  -- started and only at a white character that has been entered during the
  -- current insert command.
  l = true,
  v = true,
}

-- }}}

-- Folds {{{

-- TODO: fix ass
-- vim.opt.foldtext = 'v:lua.luavim.folds()'
vim.opt.foldopen = vim.opt.foldopen + 'search'
vim.opt.foldlevelstart = 3
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldexpr = ""               -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
-- vim.opt.foldmethod = 'expr'
vim.opt.foldmethod = 'manual'

-- }}}

-- Grepprg {{{

-- Use faster grep alternatives if possible
-- TO BE FIXED -- if luavim.executable 'rg' then
-- TO BE FIXED --   vim.o.grepprg = [[rg --glob "!.git" --no-heading --vimgrep --follow $*]]
-- TO BE FIXED --   vim.opt.grepformat = vim.opt.grepformat ^ { '%f:%l:%c:%m' }
-- TO BE FIXED -- elseif luavim.executable 'ag' then
-- TO BE FIXED --   vim.o.grepprg = [[ag --nogroup --nocolor --vimgrep]]
-- TO BE FIXED --   vim.opt.grepformat = vim.opt.grepformat ^ { '%f:%l:%c:%m' }
-- TO BE FIXED -- end

-- }}}

-- Wild and file globbing stuff in command mode {{{

-- vim.opt.wildcharm = vim.fn.char2nr(luavim.replace_termcodes [[<Tab>]])
vim.opt.wildmode = 'longest:full,full' -- Shows a menu bar as opposed to an enormous list
vim.opt.wildignorecase = true -- Ignore case when completing file names and directories
-- Binary
vim.opt.wildignore = {
  '*.aux', '*.out', '*.toc', '*.o', '*.obj', '*.dll', '*.jar', '*.pyc',
  '*.rbc', '*.class', '*.gif', '*.ico', '*.jpg', '*.jpeg', '*.png', '*.avi',
  '*.wav',
  -- Temp/System
  '*.*~', '*~ ', '*.swp', '.lock', '.DS_Store', 'tags.lock',
}
vim.opt.wildoptions = 'pum'
vim.opt.pumblend = 3 -- Make popup window translucent

-- }}}

-- Display {{{

vim.opt.conceallevel = 0 -- or 2
vim.opt.breakindentopt = 'sbr'
vim.opt.linebreak = true -- lines wrap at words rather than random characters
vim.opt.synmaxcol = 1024 -- don't syntax highlight long lines
-- FIXME: use 'auto:2-4' when the ability to set only a single lsp sign is restored
--@see: https://github.com/neovim/neovim/issues?q=set_signs
vim.opt.signcolumn = 'yes:2'
vim.opt.ruler = false
vim.opt.cmdheight = 1 -- Set command line height to one line
vim.opt.showbreak = [[↪ ]] -- Options include -> '…', '↳ ', '→','↪ '
--- This is used to handle markdown code blocks where the language might
--- be set to a value that isn't equivalent to a vim filetype
vim.g.markdown_fenced_languages = {
  'js=javascript',
  'ts=typescript',
  'shell=sh',
  'bash=sh',
  'console=sh',
}

-- }}}

-- List chars {{{

vim.opt.list = true -- invisible chars
vim.opt.listchars = {
  eol = nil,
  tab = '│ ',
  extends = '›', -- Alternatives: … »
  precedes = '‹', -- Alternatives: … «
  trail = '•', -- BULLET (U+2022, UTF-8: E2 80 A2)
}

-- }}}

-- Tabs and identations {{{

vim.opt.wrap = false
vim.opt.wrapmargin = 2
vim.opt.textwidth = 80
vim.opt.autoindent = true
vim.opt.shiftround = true
vim.opt.tabstop = 2                 -- insert 2 spaces for a tab
vim.opt.shiftwidth = 2              -- the number of spaces inserted for each indentation
vim.opt.expandtab = true            -- convert tabs to spaces
vim.opt.smartindent = true          -- make indenting smarter again
vim.opt.showtabline = 2             -- always show tabs

-- }}}

-- Line numbers  {{{

vim.opt.number = true               -- set numbered lines
vim.opt.relativenumber = true       -- set relative numbered lines
vim.opt.numberwidth = 2             -- set number column width to 2 {default 4}

-- }}}

-- }}}

-- Emoji {{{

-- emoji is true by default but makes (n)vim treat all emoji as double width
-- which breaks rendering so we turn this off.
-- CREDIT: https://www.youtube.com/watch?v=F91VWOelFNE
vim.opt.emoji = false
--- NOTE: remove this once 0.6 lands, it is now default
vim.opt.inccommand = 'nosplit'

-- }}}

-- Cursor {{{

vim.opt.cursorline = true           -- highlight the current line

-- This is from the help docs, it enables mode shapes, "Cursor" highlight, and blinking
vim.opt.guicursor = {
  [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]],
  [[a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor]],
  [[sm:block-blinkwait175-blinkoff150-blinkon175]],
}

-- }}}

-- Title {{{

-- vim.opt.titlestring = require('luavim.external').title_string() or ' ❐ %t %r %m'
-- vim.opt.titleold = fn.fnamemodify(vim.loop.os_getenv 'SHELL', ':t')
vim.opt.title = true
vim.opt.titlestring = "nvim"        -- what the title of the window will be set to
-- opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
vim.opt.titlelen = 70

-- ]}}

-- Utilities {{{

vim.opt.showmode = false
vim.opt.sessionoptions = {
  'globals',
  'buffers',
  'curdir',
  'help',
  'winpos',
  -- "tabpages",
}
vim.opt.viewoptions = { 'cursor', 'folds' } -- save/restore just these (with `:{mk,load}view`)
vim.opt.virtualedit = 'block' -- allow cursor to move where there is no text in visual block mode

-- }}}

-- Shada (Shared Data) {{{
-- NOTE: don't store marks as they are currently broke i.e.
-- are incorrectly resurrected after deletion
-- replace '100 with '0 the default which stores 100 marks
-- add f0 so file marks aren't stored
-- @credit: wincent
-- vim.opt.shada = "!,'0,f0,<50,s10,h"

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
    vim.g["loaded_" .. plugin] = 1
end

-- }}}

-- netrw config {{{

vim.g.netrw_fastbrowse = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_localrmdir='rm -r'

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

-- Backup and swaps {{{

vim.opt.undofile = true             -- enable persistent undo
vim.opt.undodir = os.getenv("HOME") .. "/.cache/undo"   -- set an undo directory

vim.opt.swapfile = false            -- creates a swapfile
vim.opt.backup = false              -- creates a backup file
vim.opt.writebackup = false         -- if a file is being edited by another program (or was written to file while editing with another program),it is not allowed to be edited


-- if fn.isdirectory(vim.o.undodir) == 0 then
--   fn.mkdir(vim.o.undodir, 'p')
-- end
-- -- The // at the end tells Vim to use the absolute path to the file to create the swap file.
-- -- This will ensure that swap file name is unique, so there are no collisions between files
-- -- with the same name from different directories.
-- vim.opt.directory = fn.stdpath 'data' .. '/swap//'
-- if fn.isdirectory(vim.o.directory) == 0 then
--   fn.mkdir(vim.o.directory, 'p')
-- end

vim.g.auto_save = false

--}}}

-- Match and search {{{

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrapscan = true -- Searches wrap around the end of the file
vim.opt.scrolloff = 9
vim.opt.sidescrolloff = 10
vim.opt.sidescroll = 1

-- }}}

-- Spelling {{{

-- vim.opt.spelllang = "en"
-- vim.opt.spell = false
vim.opt.spellsuggest:prepend { 12 }
vim.opt.spelloptions = 'camel'
vim.opt.spellcapcheck = '' -- don't check for capital letters at start of sentence
vim.opt.fileformats = { 'unix', 'mac', 'dos' }

-- }}}

-- Mouse {{{

vim.opt.mouse = 'a'
vim.opt.mousefocus = true

-- }}}

-- Others {{{
--
-- these only read ".vim" files
vim.opt.secure = true -- Disable autocmd etc for project local vimrc files.
vim.opt.exrc = true -- Allow project local vimrc files example .nvimrc see :h exrc
vim.opt.whichwrap:append("<>hl") -- TODO what is this?
-- vim.opt.whichwrap:append("+=<,>,[,],h,l")

vim.opt.joinspaces = false
vim.opt.gdefault = true
-- vim.opt.cul = true TODO: what is this
vim.opt.fileencoding = "utf-8"      -- the encoding written to a file
vim.opt.pumheight = 10  -- or 15, pop up menu height
vim.opt.confirm = true -- make vim prompt me to save before doing destructive things
vim.opt.completeopt = { 'menuone', 'noselect' }  -- mostly for cmp
vim.opt.hlsearch = false  -- if true highlights all matches on previous search pattern
vim.opt.autowriteall = true -- automatically :write before running commands and changing files
vim.opt.clipboard = { 'unnamedplus' }
vim.opt.laststatus = 2
vim.opt.termguicolors = true
-- vim.opt.guifont = 'Fira Code Regular Nerd Font Complete Mono:h14'

-- Don't show status line on vim terminals
-- vim.cmd [[ au TermOpen term://* setlocal nonumber laststatus=0 ]]
-- vim.cmd [[set iskeyword+=-]]

-- Open a file from its last left off position
-- vim.cmd [[ au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]
-- File extension specific tabbing
-- vim.cmd [[ autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 ]]

-- }}}

-- Git editor {{{

-- if luavim.executable 'nvr' then
--   vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
--   vim.env.EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
-- end

-- }}}


-- vim:foldmethod=marker
