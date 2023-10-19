-- Quickfix
-- ...
--

return {
    {
        url = "https://gitlab.com/yorickpeterse/nvim-pqf",
        event = "QuickFixCmdPre",
        -- config = function()
        --     highlight.plugin("pqf", {
        --         theme = {
        --             ["doom-one"] = { { qfPosition = { link = "Todo" } } },
        --             ["horizon"] = { { qfPosition = { link = "String" } } },
        --         },
        --     })
        --     require("pqf").setup()
        -- end,
    },
    {
        "kevinhwang91/nvim-bqf",
        event = "QuickFixCmdPre",
        config = function()
            require("bqf").setup({
                auto_enable = true,
                preview = {
                    win_height = 12,
                    win_vheight = 12,
                    delay_syntax = 80,
                    border_chars = {
                        "┃",
                        "┃",
                        "━",
                        "━",
                        "┏",
                        "┓",
                        "┗",
                        "┛",
                        "█",
                    },
                    should_preview_cb = function(bufnr)
                        local ret = true
                        local filename = vim.api.nvim_buf_get_name(bufnr)
                        local fsize = vim.fn.getfsize(filename)
                        -- file size greater than 100k can't be previewed automatically
                        if fsize > 100 * 1024 then
                            ret = false
                        end
                        return ret
                    end,
                },
                -- make `drop` and `tab drop` to become preferred
                func_map = {
                    drop = "o",
                    openc = "O",
                    split = "<C-s>",
                    tabdrop = "<C-t>",
                    tabc = "",
                    ptogglemode = "z,",
                },
                filter = {
                    fzf = {
                        action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tab drop" },
                        extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
                    },
                },
            })
            --     highlight.plugin(
            --         "bqf",
            --         { { BqfPreviewBorder = { fg = { from = "Comment" } } } }
            --     )
        end,
    },
    --  {
    --     -- TODO : make shure this works properly
    --     "ojroques/vim-oscyank",
    --     disable = false,
    --     keys = "<leader>y",
    --     config = function()
    --         vim.cmd [[
    --   vnoremap <leader>y :OSCYank<CR>
    --   nmap <leader>y <Plug>OSCYank
    --   ]]
    --     end,
    -- }
    -- {
    --   "ethanholz/nvim-lastplace",
    --   disable = false,
    --   -- event = "BufWinEnter",
    --   config = function()
    --     require("nvim-lastplace").setup({
    --       lastplace_ignore_buftype = { "alpha", "quickfix", "nofile", "help" },
    --       lastplace_ignore_filetype = {
    --         "gitcommit",
    --         "gitrebase",
    --         "svn",
    --         "hgcommit",
    --       },
    --       lastplace_open_folds = true,
    --     })
    --   end,
    -- },
    { "motosir/skel-nvim", event = "BufNewFile" },
    -- {
    --   "noahfrederick/vim-skeleton",
    --   event = "BufNewFile",
    --   config = function()
    --     vim.g.skeleton_template_dir = vim.fn.expand("~/.config/nvim")
    --       .. "/templates"
    --     vim.cmd([[
    --       let g:skeleton_replacements = {}
    --       function! g:skeleton_replacements.TITLE()
    --         return toupper(expand("%:t:r"))
    --       endfunction
    --     ]])
    --   end,
    -- },
}

-- vim: foldmethod=marker sw=2 ts=2 sts=2
