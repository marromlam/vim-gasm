local M = {}
M.config = function()
  local status_ok, actions = pcall(require, "telescope.actions")
  if not status_ok then
    return
  end

  nvim.builtin.telescope = {
    active = false,
    defaults = {
      prompt_prefix = "   ",
      selection_caret = " ➜ ",
      entry_prefix = "   ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "horizontal",
      layout_config = {
        width = 0.8,
        prompt_position = "bottom",
        preview_cutoff = 100,
        horizontal = { mirror = false },
        vertical = { mirror = false },
      },
      file_sorter = require("telescope.sorters").get_fzy_sorter,
      file_ignore_patterns = {},
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      -- path_display = { shorten = 5 },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      --
      -- borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
      -- borderchars = {
      --   { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
      --   prompt = {"─", "│", " ", "│", '┌', '┐', "│", "│"},
      --   results = {"─", "│", "─", "│", "├", "┤", "┘", "└"},
      --   preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└'},
      -- },
      --
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      -- file_previewer = require("telescope.theme").vim_buffer_cat.new,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

      -- Developer configurations: Not meant for general override
      -- buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      mappings = {
        i = {
          ["<C-n>"] = actions.move_selection_next,
          ["<C-p>"] = actions.move_selection_previous,
          ["<C-c>"] = actions.close,
          ["<C-j>"] = actions.cycle_history_next,
          ["<C-k>"] = actions.cycle_history_prev,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["<CR>"] = actions.select_default + actions.center,
          -- To disable a keymap, put [map] = false
          -- So, to not map "<C-n>", just put
          -- ["<c-t>"] = trouble.open_with_trouble,
          -- ["<c-x>"] = false,
          -- ["<esc>"] = actions.close,
          -- Otherwise, just set the mapping to the function that you want it to be.
          -- ["<C-i>"] = actions.select_horizontal,
          -- Add up multiple actions
          -- You can perform as many actions in a row as you like
          -- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
        },
        n = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          -- ["<c-t>"] = trouble.open_with_trouble,
          -- ["<C-i>"] = my_cool_custom_action,
        },
      },
    },
    pickers = {
      -- Your special builtin config goes in here
      buffers = {
        theme = "ivy",
        sort_lastused = true,
        results_title = '',
        preview_title = '',
        prompt_title = '',
        -- prompt_prefix = '',
        -- previewer = false,
        layout_config = {
          height = 0.25,
          -- preview_width = 0.5,
          vertical = { mirror = true },
          prompt_position = "bottom",
        }
      },
      find_files = {
        results_title = '',
        preview_title = '',
        prompt_title = '',
        winblend = 0,
        layout_config = {
          width = 0.8,
          height = 0.8,
          -- prompt_position = "bottom",
          -- preview_cutoff = 100,
          preview_width = 0.5,
          horizontal = { mirror = false },
          vertical = { mirror = false },
        },
        -- prompt_prefix = 'Files>',
        -- previewer = 0.5,
        -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      }
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
    },
  }
end

M.setup = function()
  local status_ok, telescope = pcall(require, "telescope")
  if not status_ok then
    return
  end
  telescope.setup(nvim.builtin.telescope)
end

return M
