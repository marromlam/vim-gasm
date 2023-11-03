return {
    {
        "antonk52/bad-practices.nvim",
        cond = false,
    },
    -- {
    --     "m4xshen/hardtime.nvim",
    --     dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    --     enable = false,
    --     opts = {},
    -- },
    {
        "mbbill/undotree",
        keys = {
            {
                "<leader>u",
                vim.cmd.UndotreeToggle,
                "Toggle undotree",
            },
        },
    },
}
