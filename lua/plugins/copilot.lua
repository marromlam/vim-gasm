-- highlight = mrl.highlight
return {
  {
    "github/copilot.vim",
    event = "InsertEnter",
    -- dependencies = { "nvim-cmp" },
    init = function()
      vim.g.copilot_no_tab_map = true
    end,
    config = function()
      local function accept_word()
        vim.fn["copilot#Accept"]("")
        local output = vim.fn["copilot#TextQueuedForInsertion"]()
        return vim.fn.split(output, [[[ .]\zs]])[1]
      end

      local function accept_line()
        vim.fn["copilot#Accept"]("")
        local output = vim.fn["copilot#TextQueuedForInsertion"]()
        return vim.fn.split(output, [[[\n]\zs]])[1]
      end
      map("i", "<Plug>(as-copilot-accept)", "copilot#Accept('<C-a>')", {
        expr = true,
        remap = true,
        silent = true,
      })
      map("i", "<M-]>", "<Plug>(copilot-next)", { desc = "next suggestion" })
      map(
        "i",
        "<M-[>",
        "<Plug>(copilot-previous)",
        { desc = "previous suggestion" }
      )
      map(
        "i",
        "<C-§>",
        "<Cmd>vertical Copilot panel<CR>",
        { desc = "open copilot panel" }
      )
      map(
        "i",
        "<M-w>",
        accept_word,
        { expr = true, remap = false, desc = "accept word" }
      )
      map(
        "i",
        "<C-a>",
        accept_line,
        { expr = true, remap = false, desc = "accept line" }
      )
      vim.g.copilot_filetypes = {
        ["*"] = true,
        gitcommit = false,
        NeogitCommitMessage = false,
        DressingInput = false,
        TelescopePrompt = false,
        ["neo-tree-popup"] = false,
        ["dap-repl"] = false,
      }
      -- highlight.plugin(
      --   "copilot",
      --   { { CopilotSuggestion = { link = "Comment" } } }
      -- )
    end,
  },
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   dependencies = "copilot.lua",
  --   event = "InsertEnter",
  --   opts = {},
  --   config = function(_, opts)
  --     local copilot_cmp = require("copilot_cmp")
  --     copilot_cmp.setup(opts)
  --     -- attach cmp source whenever copilot attaches
  --     -- fixes lazy-loading issues with the copilot cmp source
  --     require("lazyvim.util").on_attach(function(client)
  --       if client.name == "copilot" then
  --         copilot_cmp._on_insert_enter({})
  --       end
  --     end)
  --   end,
  -- },
}
