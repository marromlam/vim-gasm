vim.o.termguicolors = true


local M = {}


M.config = function()
  local status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
  if not status_ok then
    return
  end

  vim.g.nvim_tree_side = "left"
  vim.g.nvim_tree_width = 30
  vim.g.nvim_tree_ignore = {".git", "node_modules", ".cache"}
  vim.g.nvim_tree_gitignore = 0
  vim.g.nvim_tree_auto_ignore_ft = {"dashboard"} -- don't open tree on specific fiypes.
  vim.g.nvim_tree_auto_open = 0
  vim.g.nvim_tree_auto_close = 0 -- closes tree when it's the last window
  vim.g.nvim_tree_quit_on_open = 0 -- closes tree when file's opened
  vim.g.nvim_tree_follow = 1
  vim.g.nvim_tree_indent_markers = 1
  vim.g.nvim_tree_hide_dotfiles = 1
  vim.g.nvim_tree_git_hl = 1
  vim.g.nvim_tree_highlight_opened_files = 0
  vim.g.nvim_tree_root_folder_modifier = table.concat {":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??"}
  vim.g.nvim_tree_tab_open = 0
  vim.g.nvim_tree_allow_resize = 1
  vim.g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
  vim.g.nvim_tree_disable_netrw = 0
  vim.g.nvim_tree_hijack_netrw = 1
  vim.g.nvim_tree_update_cwd = 1
  --
  vim.g.nvim_tree_icons = {
      default = "",
      symlink = "",
      git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌"
      },
      folder = {
          -- arrow_open = "",
          -- arrow_closed = "",
          default = "",
          open = "",
          empty = "", -- 
          empty_open = "",
          symlink = "",
          symlink_open = ""
      }
  }

  -- following options are the default
  nvim_tree_config.setup {
    -- disables netrw completely
    disable_netrw       = false,
    -- hijack netrw window on startup
    hijack_netrw        = false,
    -- open the tree when running this setup function
    open_on_setup       = false,
    -- will not open on setup if the filetype is in this list
    ignore_ft_on_setup  = {},
    -- closes neovim automatically when the tree is the last **WINDOW** in the view
    auto_close          = false,
    -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
    open_on_tab         = false,
    -- hijacks new directory buffers when they are opened.
    update_to_buf_dir   = {
      -- enable the feature
      enable = true,
      -- allow to open the tree if it was previously closed
      auto_open = true,
    },
    -- hijack the cursor in the tree to put it at the start of the filename
    hijack_cursor       = false,
    -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
    update_cwd          = false,
    -- show lsp diagnostics in the signcolumn
    lsp_diagnostics     = false,
    -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
    update_focused_file = {
      -- enables the feature
      enable      = false,
      -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
      -- only relevant when `update_focused_file.enable` is true
      update_cwd  = false,
      -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
      -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
      ignore_list = {}
    },
    -- configuration options for the system open command (`s` in the tree by default)
    system_open = {
      -- the command to run this, leaving nil should work in most cases
      cmd  = nil,
      -- the command arguments as a list
      args = {}
    },
  
    view = {
      -- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
      width = 30,
      -- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
      height = 30,
      -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
      side = 'left',
      -- if true the tree will resize itself after opening a file
      auto_resize = false,
      mappings = {
        -- custom only false will merge the list with the default mappings
        -- if true, it will only use your list to set the mappings
        custom_only = false,
        -- list of mappings to set on the tree manually
        list = {}
      }
    }
  }

  --
  local tree_cb = nvim_tree_config.nvim_tree_callback
  vim.g.nvim_tree_bindings = {
      {key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit")},
      {key = {"<2-RightMouse>", "<C-]>"}, cb = tree_cb("cd")},
      {key = "<C-v>", cb = tree_cb("vsplit")},
      {key = "<C-x>", cb = tree_cb("split")},
      {key = "<C-t>", cb = tree_cb("tabnew")},
      {key = "<", cb = tree_cb("prev_sibling")},
      {key = ">", cb = tree_cb("next_sibling")},
      {key = "P", cb = tree_cb("parent_node")},
      {key = "<BS>", cb = tree_cb("close_node")},
      {key = {"<S-CR>", "h"}, cb = tree_cb("close_node")},
      {key = {"<CR>", "l"}, cb = tree_cb("open_node")},
      {key = "<Tab>", cb = tree_cb("preview")},
      {key = "K", cb = tree_cb("first_sibling")},
      {key = "J", cb = tree_cb("last_sibling")},
      {key = "I", cb = tree_cb("toggle_ignored")},
      {key = "H", cb = tree_cb("toggle_dotfiles")},
      {key = "R", cb = tree_cb("refresh")},
      {key = "a", cb = tree_cb("create")},
      {key = "d", cb = tree_cb("remove")},
      {key = "r", cb = tree_cb("rename")},
      {key = "<C->", cb = tree_cb("full_rename")},
      {key = "x", cb = tree_cb("cut")},
      {key = "c", cb = tree_cb("copy")},
      {key = "p", cb = tree_cb("paste")},
      {key = "y", cb = tree_cb("copy_name")},
      {key = "Y", cb = tree_cb("copy_path")},
      {key = "gy", cb = tree_cb("copy_absolute_path")},
      {key = "[c", cb = tree_cb("prev_git_item")},
      {key = "}c", cb = tree_cb("next_git_item")},
      {key = "-", cb = tree_cb("dir_up")},
      {key = "q", cb = tree_cb("close")},
      {key = "g?", cb = tree_cb("toggle_help")}
  }

  -- hide statusline when nvim tree is opened
  -- vim.cmd [[au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif]]
end


-- -- -- M.setup = function()
-- -- --   local status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
-- -- --   if not status_ok then
-- -- --     return
-- -- --   end
-- -- --   local g = vim.g
-- -- -- 
-- -- --   for opt, val in pairs(nvim.builtin.nvimtree) do
-- -- --     g["nvim_tree_" .. opt] = val
-- -- --   end
-- -- -- 
-- -- --   local tree_cb = nvim_tree_config.nvim_tree_callback
-- -- -- 
-- -- --   if not g.nvim_tree_bindings then
-- -- --     g.nvim_tree_bindings = {
-- -- --       { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
-- -- --       { key = "h", cb = tree_cb "close_node" },
-- -- --       { key = "v", cb = tree_cb "vsplit" },
-- -- --     }
-- -- --   end
-- -- -- end


-- M.focus_or_close = function()
--   local view_status_ok, view = pcall(require, "nvim-tree.view")
--   if not view_status_ok then
--     return
--   end
--   local a = vim.api
-- 
--   local curwin = a.nvim_get_current_win()
--   local curbuf = a.nvim_win_get_buf(curwin)
--   local bufnr = view.View.bufnr
--   local winnr = view.get_winnr()
-- 
--   if view.win_open() then
--     if curwin == winnr and curbuf == bufnr then
--       view.close()
--       if package.loaded["bufferline.state"] then
--         require("bufferline.state").set_offset(0)
--       end
--     else
--       view.focus()
--     end
--   else
--     view.open()
--     if package.loaded["bufferline.state"] and nvim.builtin.nvimtree.side == "left" then
--       -- require'bufferline.state'.set_offset(nvim.builtin.nvimtree.width + 1, 'File Explorer')
--       require("bufferline.state").set_offset(nvim.builtin.nvimtree.width + 1, "")
--     end
--   end
-- end


-- M.toggle_tree = function()
--   local view_status_ok, view = pcall(require, "nvim-tree.view")
--   if not view_status_ok then
--     return
--   end
--   if view.win_open() then
--     require("nvim-tree").close()
--     if package.loaded["bufferline.state"] then
--       require("bufferline.state").set_offset(0)
--     end
--   else
--     if package.loaded["bufferline.state"] and nvim.builtin.nvimtree.side == "left" then
--       -- require'bufferline.state'.set_offset(nvim.builtin.nvimtree.width + 1, 'File Explorer')
--       require("bufferline.state").set_offset(nvim.builtin.nvimtree.width + 1, "")
--     end
--     require("nvim-tree").toggle()
--   end
-- end


function M.change_tree_dir(dir)
  if vim.g.loaded_tree then
    require("nvim-tree.lib").change_dir(dir)
  end
end


return M


-- vim:foldmethod=marker
