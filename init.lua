vim.cmd [[
  set packpath^=~/.config/nvim/autoload
  set packpath^=~/.config/nvim

  set runtimepath+=~/.config/nvim
  set runtimepath^=~/.config/nvim/after
]]
-- vim.opt.rtp:append() instead of vim.cmd ?


vim.cmd("silent! command PackerCompile lua require 'packer_all' require('packer').compile()")
vim.cmd("silent! command PackerInstall lua require 'packer_all' require('packer').install()")
vim.cmd("silent! command PackerStatus lua require 'packer_all' require('packer').status()")
vim.cmd("silent! command PackerSync lua require 'packer_all' require('packer').sync()")
vim.cmd("silent! command PackerUpdate lua require 'packer_all' require('packer').update()")


local nvim_path = os.getenv "HOME" .. "/.config/nvim/"
USER_CONFIG_PATH = nvim_path .. "config.lua"

require "default-config"
-- require "all-packs"

-- require("keys.mappings").setup()
nvim.colorscheme = "material"
vim.g.colors_style = "darker"
-- vim.g.colors_lighter_contrast = true

local autocmds = require "pack-config.autocmds"
require("general.settings").load_options()

local status_ok, error = pcall(vim.cmd, "luafile " .. USER_CONFIG_PATH)
if not status_ok then
  print("Something is wrong with your " .. USER_CONFIG_PATH)
  print(error)
end

require("general.settings").load_commands()
autocmds.define_augroups(nvim.autocommands)


-- Load plugings
-- local plugins = require "plugins"
-- local plugin_loader = require("all-packs").init()
-- plugin_loader:load { plugins, nvim.plugins }


-- TO BE MOVED {{{

vim.g.netrw_bufsettings = "noma nomod nonu nowrap ro nobuflisted"

vim.g.nvim_tree_disable_netrw = 0 -- 1 by default, disables netrw
vim.g.nvim_tree_hijack_netrw = 0 -- 1 b

-- Set barbar's options {{{


-- }}}

-- {{{

vim.g.python3_host_prog = vim.fn.expand(os.getenv "HOMEBREW" .. "/bin/python3.9")
vim.g.pydocstring_doq_path = os.getenv "HOMEBREW" .. "/bin/doq"

vim.g.lsp_settings = {
  clangd = {
    cmd = "/home3/marcos.romero/.linuxbrew/bin/clangd"
  }
}


vim.cmd [[
xmap <S-CR> <Plug>SlimeRegionSend<CR>

" make sure that viewer is selected according to the suffix.
let g:netrw_browsex_viewer="-"

" functions for file extension '.md'.
function! NFH_md(f)
    execute '!typora' a:f
endfunction

" functions for file extension '.pdf'.
function! NFH_pdf(f)
    execute '!zathura' a:f
endfunction
]]
-- set fillchars=fold:\ ,vert:\│,eob:\ ,msgsep:‾

-- }}}


-- local snap = require'snap'

-- local file = snap.config.file:with {reverse = true, suffix = ">>", consumer = "fzf"}
-- local vimgrep = snap.config.vimgrep:with {reverse = true, suffix = ">>", limit = 50000}


-- snap.maps {
--   {"<Leader><Leader>", snap.config.file {producer = "ripgrep.file"}, {command = "ripgrepfile"}},
--   {"<Leader>fb", snap.config.file {producer = "vim.buffer"}, {command = "buffers"}},
--   {"<Leader>fo", snap.config.file {producer = "vim.oldfile"}, {command = "oldfiles"}},
--   {"<Leader>ff", snap.config.vimgrep {}, {command = "nose"}},
-- }
-- 
-- 
-- snap.register.map({'n'}, {'<space>g'}, function()
--     snap.run({
--         prompt = '❯',
--         producer = snap.get'consumer.fzf'(snap.get'producer.git.general'.args {"--status"}),
--         select = snap.get'select_file'.select,
--         multiselect = snap.get'select_file'.multiselect
--     })
-- end)




-- local icons = require 'nvim-web-devicons'
-- require('nvim-web-devicons').setup { default = true }


-- local fnamemodify = vim.fn.fnamemodify
-- local get_icon = icons.get_icon
-- local function add_icon(meta_result)
--   local filename = fnamemodify(meta_result.result, ':t:r')
--   local extension = fnamemodify(meta_result.result, ':e')
--   local icon = get_icon(filename, extension)
--   return icon .. ' ' .. meta_result.result
-- end
-- 
-- 
-- local function icons_consumer(producer)
--   return function(request)
--     for results in snap.consume(producer, request) do
--       if type(results) == 'table' then
--         if not vim.tbl_islist(results) then
--           coroutine.yield(results)
--         else
--           coroutine.yield(vim.tbl_map(function(result)
--             return snap.with_metas(result, { display = add_icon, highlight_offset = 4 })
--           end, results))
--         end
--       else
--         coroutine.yield(nil)
--       end
--     end
--   end
-- end
-- 
-- 
-- snap.register.map('n', '<Leader>Os',
--   snap.create(
--     function()
--       return {
--         prompt = 'Git Files',
--         producer = snap.get'consumer.fzf'(
--           snap.get'consumer.try'(
--             snap.get'producer.git.file',
--             snap.get'producer.ripgrep.file'
--           )
--         ),
--         select = snap.get'select.file'.select,
--         multiselect = snap.get'select.file'.multiselect,
--         views = {snap.get'preview.file'},
--       }
--     end
--   )
-- )
-- 
-- 
-- snap.register.map( 'n', '<Leader>Of',
--   snap.create(
--     function()
--       return {
--         prompt = 'Git Files',
--         producer = icons_consumer(snap.get 'consumer.fzf'(snap.get 'producer.fd.file')),
--         select = snap.get('select.file').select,
--         multiselect = snap.get('select.file').multiselect,
--         views = { snap.get 'preview.file' },
--       }
--   end)
-- )
-- 
-- 
-- snap.register.map( 'n', '<Leader>Ol',
--   snap.create(function()
--     return {
--       prompt = 'Ripgrep',
--       producer = snap.get 'consumer.limit'(50000, snap.get 'producer.ripgrep.vimgrep'),
--       select = snap.get('select.vimgrep').select,
--       multiselect = snap.get('select.vimgrep').multiselect,
--       views = { snap.get 'preview.vimgrep' },
--     }
--   end)
-- )
-- 
-- 
-- snap.register.map( 'n', '<leader>Ob',
--   snap.create(function()
--     return {
--       prompt = 'Buffers',
--       producer = icons_consumer(snap.get 'consumer.fzf'(snap.get 'producer.vim.buffer')),
--       select = snap.get('select.file').select,
--       multiselect = snap.get('select.file').multiselect,
--       views = { snap.get 'preview.file' },
--     }
--   end)
-- )
-- 
-- 
-- require('indent_guides').setup({
--   indent_levels = 30;
--   indent_guide_size = 1;
--   indent_start_level = 1;
--   indent_enable = true;
--   indent_space_guides = true;
--   indent_tab_guides = false;
--   indent_soft_pattern = '\\s';
--   exclude_filetypes = {'help','dashboard','dashpreview','NvimTree','vista','sagahover'};
--   even_colors = { fg ='#2a3834',bg='#332b36' };
--   odd_colors = {fg='#332b36',bg='#2a3834'};
-- })

-- }}}


-- Set theme
-- require "general.theme"
require("appearance")


-- Some utils
-- local utils = require "utils"
-- utils.toggle_autoformat()
-- local commands = require "pack-config.commands"
-- commands.load(commands.defaults)


-- LSP
-- require("lsp").config()
-- 
-- local null_status_ok, null_ls = pcall(require, "null-ls")
-- if null_status_ok then
--   null_ls.config {}
--   require("lspconfig")["null-ls"].setup {}
-- end
-- 
-- local lsp_settings_status_ok, lsp_settings = pcall(require, "nlspsettings")
-- if lsp_settings_status_ok then
--   lsp_settings.setup {
--     config_home = os.getenv "HOME" .. "/.config/nvim/lsp-settings",
--   }
-- end


-- Key mappings
require("keys.mappings").setup()


-- vim:foldmethod=marker
