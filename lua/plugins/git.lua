local cwd = vim.fn.getcwd
local highlight = mrl.highlight
local border = mrl.ui.current.border
local icons = mrl.ui.icons.separators

--- Require on index.
---
--- Will only require the module after the first index of a module.
--- Only works for modules that export a table.
function mrl.reqidx(require_path)
  return setmetatable({}, {
    __index = function(_, key)
      return require(require_path)[key]
    end,
    __newindex = function(_, key, value)
      require(require_path)[key] = value
    end,
  })
end

--
-- local neogit = mrl.reqidx("neogit")
local gitlinker = mrl.reqidx("gitlinker")

local function browser_open()
  return { action_callback = require("gitlinker.actions").open_in_browser }
end

vim.cmd([[ set diffopt+=vertical ]])

return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git" },
    keys = {
      {
        "<leader>gs",
        "<Cmd>Git<CR>",
        desc = "Git status",
        mode = "n",
      },
      {
        "<leader>g-",
        "<cmd>lua require 'gitsigns'.blame_line()<cr>",
        desc = "Blame",
      },
      {
        "<leader>gb",
        "<cmd>FzfLua git_branches<cr>",
        desc = "Checkout branch",
      },
      { "<leader>gf", "<cmd>Git fetch<cr>", desc = "Git fetch" },
      { "<leader>gh", "<cmd>diffget //2<cr>", desc = "Get diff from left" },
      {
        "<leader>gj",
        "<cmd>lua require 'gitsigns'.next_hunk()<cr>",
        desc = "Next Hunk",
      },
      {
        "<leader>gk",
        "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
        desc = "Prev Hunk",
      },
      { "<leader>gl", "<cmd>diffget //3<cr>", desc = "Get diff from right" },
      { "<leader>gB", "<cmd>Git blame<cr>", desc = "Git Blame" },
      {
        "<leader>gc",
        "<cmd>Telescope git_commits<cr>",
        desc = "Checkout commit",
      },
      {
        "<leader>gC",
        "<cmd>Telescope git_bcommits<cr>",
        desc = "Checkout commit(for current file)",
      },
      {
        "<leader>go",
        "<cmd>Telescope git_status<cr>",
        desc = "Open changed file",
      },
      { "<leader>gP", "<cmd>Git push<cr>", desc = "Git push" },
      { "<leader>gp", "<cmd>Git pull --rebase<cr>", desc = "Git pull" },
      { "<leader>gt", ":Git push -u origin ", desc = "git: set target branch" },
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      {
        "<localleader>gd",
        "<Cmd>DiffviewOpen<CR>",
        desc = "diffview: open",
        mode = "n",
      },
      {
        "gh",
        [[:'<'>DiffviewFileHistory<CR>]],
        desc = "diffview: file history",
        mode = "v",
      },
      {
        "<localleader>gh",
        "<Cmd>DiffviewFileHistory<CR>",
        desc = "diffview: file history",
        mode = "n",
      },
    },
    opts = {
      default_args = { DiffviewFileHistory = { "%" } },
      enhanced_diff_hl = true,
      hooks = {
        diff_buf_read = function()
          local opt = vim.opt_local
          opt.wrap, opt.list, opt.relativenumber = false, false, false
          opt.colorcolumn = ""
        end,
      },
      keymaps = {
        view = { q = "<Cmd>DiffviewClose<CR>" },
        file_panel = { q = "<Cmd>DiffviewClose<CR>" },
        file_history_panel = { q = "<Cmd>DiffviewClose<CR>" },
      },
    },
    config = function(_, opts)
      highlight.plugin("diffview", {
        {
          DiffAddedChar = {
            bg = "NONE",
            fg = { from = "diffAdded", attr = "bg", alter = 0.3 },
          },
        },
        {
          DiffChangedChar = {
            bg = "NONE",
            fg = { from = "diffChanged", attr = "bg", alter = 0.3 },
          },
        },
        { DiffviewStatusAdded = { link = "DiffAddedChar" } },
        { DiffviewStatusModified = { link = "DiffChangedChar" } },
        { DiffviewStatusRenamed = { link = "DiffChangedChar" } },
        { DiffviewStatusUnmerged = { link = "DiffChangedChar" } },
        { DiffviewStatusUntracked = { link = "DiffAddedChar" } },
      })
      require("diffview").setup(opts)
    end,
  },
  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<localleader>gu",
        function()
          gitlinker.get_buf_range_url("n")
        end,
        desc = "gitlinker: copy line to clipboard",
        mode = "n",
      },
      {
        "<localleader>gu",
        function()
          gitlinker.get_buf_range_url("v")
        end,
        desc = "gitlinker: copy range to clipboard",
        mode = "v",
      },
      {
        "<localleader>go",
        function()
          gitlinker.get_repo_url(browser_open())
        end,
        desc = "gitlinker: open in browser",
      },
      {
        "<localleader>go",
        function()
          gitlinker.get_buf_range_url("n", browser_open())
        end,
        desc = "gitlinker: open current line in browser",
      },
      {
        "<localleader>go",
        function()
          gitlinker.get_buf_range_url("v", browser_open())
        end,
        desc = "gitlinker: open current selection in browser",
        mode = "v",
      },
    },
    opts = {
      mappings = nil,
      callbacks = {
        ["github-work"] = function(url_data) -- Resolve the host for work repositories
          url_data.host = "github.com"
          return require("gitlinker.hosts").get_github_type_url(url_data)
        end,
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = icons.right_block },
        change = { text = icons.right_block },
        delete = { text = icons.right_block },
        topdelete = { text = icons.right_block },
        changedelete = { text = icons.right_block },
        untracked = { text = icons.light_shade_block },
      },
      -- Experimental ------------------------------------------------------------------------------
      _inline2 = false,
      _extmark_signs = true,
      _signs_staged_enable = false,
      ----------------------------------------------------------------------------------------------
      current_line_blame = not cwd():match("dotfiles"),
      current_line_blame_formatter = " <author>, <author_time> · <summary>",
      preview_config = { border = border },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function bmap(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          map(mode, l, r, opts)
        end

        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "undo stage" })
        map(
          "n",
          "<leader>hp",
          gs.preview_hunk_inline,
          { desc = "preview current hunk" }
        )
        map(
          "n",
          "<leader>hb",
          gs.toggle_current_line_blame,
          { desc = "toggle current line blame" }
        )
        map(
          "n",
          "<leader>hd",
          gs.toggle_deleted,
          { desc = "show deleted lines" }
        )
        map(
          "n",
          "<leader>hw",
          gs.toggle_word_diff,
          { desc = "toggle word diff" }
        )
        map(
          "n",
          "<localleader>gw",
          gs.stage_buffer,
          { desc = "stage entire buffer" }
        )
        map(
          "n",
          "<localleader>gre",
          gs.reset_buffer,
          { desc = "reset entire buffer" }
        )
        map(
          "n",
          "<localleader>gbl",
          gs.blame_line,
          { desc = "blame current line" }
        )
        map("n", "<leader>lm", function()
          gs.setqflist("all")
        end, { desc = "list modified in quickfix" })
        bmap(
          { "n", "v" },
          "<leader>hs",
          "<Cmd>Gitsigns stage_hunk<CR>",
          { desc = "stage hunk" }
        )
        bmap(
          { "n", "v" },
          "<leader>hr",
          "<Cmd>Gitsigns reset_hunk<CR>",
          { desc = "reset hunk" }
        )
        bmap(
          { "o", "x" },
          "ih",
          ":<C-U>Gitsigns select_hunk<CR>",
          { desc = "select hunk" }
        )

        map("n", "[h", function()
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "go to next git hunk" })

        map("n", "]h", function()
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "go to previous git hunk" })
      end,
    },
  },
  --  {
  --     "marromlam/git-worktree.nvim",
  --     disable = true,
  --     after = "telescope.nvim",
  --     keys = { "<leader>gt", "<leader>gw" },
  --     config = function()
  --         -- require("plugins.conf3.telescope").config()
  --         require("telescope").load_extension "git_worktree"
  --     end,
  -- },
  --  {
  --     "rlch/github-notifications.nvim",
  --     disable = true,
  --     -- don't load this plugin if the gh cli is not installed
  --     cond = function()
  --         return core.executable "gh"
  --     end,
  --     requires = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  -- }
}
