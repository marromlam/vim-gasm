-- local my_vault = vim.fn.expand("~")
--   .. "/Library/Mobile Documents/iCloud~md~obsidian/Documents/**.md"
return {
    "epwalsh/obsidian.nvim",
    cmd = { "ObsidianOpen", "ObsidianNew" },
    -- lazy = true,
    -- event = {
    --   "BufReadPre " .. my_vault,
    --   "BufNewFile " .. my_vault,
    -- },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "ibhagwan/fzf-lua",
    },
    -- opts = {
    --   dir = my_vault,
    -- },
}
