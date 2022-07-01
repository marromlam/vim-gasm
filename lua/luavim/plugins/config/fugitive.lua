local wk = require "which-key"

vim.cmd [[ set diffopt+=vertical ]]

wk.register({
  ["g"] = {
    name = "Git",
    ["-"] = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    ["b"] = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    ["f"] = { "<cmd>Git fetch<cr>", "Git fetch" },
    ["h"] = { "<cmd>diffget //2<cr>", "Get diff from left" },
    ["j"] = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    ["k"] = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    ["l"] = { "<cmd>diffget //3<cr>", "Get diff from right" },
    ["B"] = { "<cmd>Git blame<cr>", "Git Blame" },
    ["c"] = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    ["C"] = { "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)" },
    ["o"] = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    ["s"] = { "<cmd>Git<cr>", "Git Status" },
    ["P"] = { "<cmd>Git push<cr>", "Git push" },
    ["p"] = { "<cmd>Git pull<cr>", "Git pull" },
  },
}, { prefix = "<leader>" })

-- FIX MAP -- core.map({"n"}, "<leader>g-", "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame")
-- FIX MAP -- core.map({"n"}, "<leader>gb", "<cmd>Telescope git_branches<cr>", "Checkout branch")
-- FIX MAP -- core.map({"n"}, "<leader>gf", "<cmd>Git fetch<cr>", "Git fetch")
-- FIX MAP -- core.map({"n"}, "<leader>gh", "<cmd>diffget //2<cr>", "Get diff from left")
-- FIX MAP -- core.map({"n"}, "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk")
-- FIX MAP -- core.map({"n"}, "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk")
-- FIX MAP -- core.map({"n"}, "<leader>gl", "<cmd>diffget //3<cr>", "Get diff from right")
-- FIX MAP -- core.map({"n"}, "<leader>gB", "<cmd>Git blame<cr>", "Git Blame")
-- FIX MAP -- core.map({"n"}, "<leader>gc", "<cmd>Telescope git_commits<cr>", "Checkout commit")
-- FIX MAP -- core.map({"n"}, "<leader>gC", "<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)")
-- FIX MAP -- core.map({"n"}, "<leader>go", "<cmd>Telescope git_status<cr>", "Open changed file")
-- FIX MAP -- -- luavim.map({"n"}, "<leader>g-", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk")
-- FIX MAP -- -- luavim.map({"n"}, "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk")
-- FIX MAP -- -- luavim.map({"n"}, "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer")
-- FIX MAP -- -- luavim.map({"n"}, "<leader>g-", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk")
-- FIX MAP -- core.map({"n"}, "<leader>gs", "<cmd>Git<cr>", "Git Status")
-- FIX MAP -- core.map({"n"}, "<leader>gP", "<cmd>Git push<cr>", "Git push")
-- FIX MAP -- core.map({"n"}, "<leader>gp", "<cmd>Git pull<cr>", "Git pull")
